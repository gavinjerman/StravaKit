//
//  StravaAuthManager.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation
import AuthenticationServices

/// Custom error for StravaRepository
enum StravaAuthError: Error, LocalizedError {
    case noToken
    case invalidAccessToken
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .noToken:
            return "No valid token found."
        case .invalidAccessToken:
            return "Invalid access token."
        case .networkError(let message):
            return "Network error: \(message)"
        }
    }
}

public final class StravaAuthManager: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    private let config: StravaConfig
    public let tokenStorage: TokenStorage
    private var authSession: ASWebAuthenticationSession?

    public init(config: StravaConfig, tokenStorage: TokenStorage) {
        self.config = config
        self.tokenStorage = tokenStorage
    }

    @MainActor
    public func authorize() async throws {
        if let appAuthURL = buildAppAuthURL(), UIApplication.shared.canOpenURL(appAuthURL) {
            await UIApplication.shared.open(appAuthURL)
            return
            // Strava app redirects back with the authorization code; If using UIKit handle it in SceneDelegate/AppDelegate
            // In SwitUI rely on "onOpenURL"
        } else {
            let authURL = buildWebAuthURL()
            let oAuthToken = try await withCheckedThrowingContinuation { continuation in
                authSession = ASWebAuthenticationSession(
                    url: authURL,
                    callbackURLScheme: config.redirectUri.components(separatedBy: "://").first,
                    completionHandler: { [weak self] callbackURL, error in
                        guard let self = self else { return }
                        if let callbackURL = callbackURL {
                            Task {
                                do {
                                    let token = try await self.handleAuthResponse(url: callbackURL)
                                    continuation.resume(returning: token)
                                } catch {
                                    continuation.resume(throwing: error)
                                }
                            }
                        } else if let error = error {
                            continuation.resume(throwing: error)
                        }
                    }
                )
                authSession?.presentationContextProvider = self
                authSession?.start()
            }
            self.tokenStorage.save(token: oAuthToken)
            return
        }
    }
    
    /// Returns a valid token, refreshing it if necessary
    public func getValidToken() async throws -> OAuthToken {
        guard let currentToken = tokenStorage.getToken() else {
            throw StravaAuthError.noToken
        }
        if currentToken.isExpired {
            return try await refreshTokenIfNeeded(currentToken: currentToken)
        }
        return currentToken
    }

    public func refreshTokenIfNeeded(currentToken: OAuthToken) async throws -> OAuthToken {
        guard currentToken.isExpired else { return currentToken }

        let url = URL(string: "https://www.strava.com/oauth/token")!
        let bodyParams: [String: Any] = [
            "client_id": config.clientId,
            "client_secret": config.clientSecret,
            "refresh_token": currentToken.refreshToken ?? "",
            "grant_type": "refresh_token"
        ]
        
        let refreshRequest = StravaRouter.refreshToken(clientId: config.clientId, 
                                                       clientSecret: config.clientSecret,
                                                       refreshToken: currentToken.refreshToken ?? "").asURLRequest()

        let (data, _) = try await URLSession.shared.data(for: refreshRequest)
        let decoder = JSONDecoder()
        let validToken = try decoder.decode(OAuthToken.self, from: data)
        
        // Save new token
        tokenStorage.save(token: validToken)
        
        // Return validToken
        return validToken
    }
    
    public func authenticated() async -> Bool {
        let token = try? await getValidToken()
        return ((token?.isExpired) != nil)
    }
    
    private func buildAppAuthURL() -> URL? {
        let baseUrl = "strava://oauth/mobile/authorize"
        let queryItems = buildAuthQueryItems()
        var components = URLComponents(string: baseUrl)
        components?.queryItems = queryItems
        return components?.url
    }

    private func buildWebAuthURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.strava.com"
        components.path = "/oauth/mobile/authorize"
        components.queryItems = buildAuthQueryItems()
        return components.url!
    }
    
    private func buildAuthQueryItems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "client_id", value: config.clientId),
            URLQueryItem(name: "redirect_uri", value: config.redirectUri),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "approval_prompt", value: config.forcePrompt ? "force" : "auto"),
            URLQueryItem(name: "scope", value: config.scopes)
        ]
    }

    // Public as authorization can be done through app and requires redirect.
    public func handleAuthResponse(url: URL) async throws -> OAuthToken {
        guard let code = URLComponents(string: url.absoluteString)?
                .queryItems?.first(where: { $0.name == "code" })?.value else {
            throw StravaError.missingAuthCode
        }

        let token = try await exchangeCodeForToken(code: code)
        
        // Save new token
        tokenStorage.save(token: token)
        
        return token
    }

    private func exchangeCodeForToken(code: String) async throws -> OAuthToken {
        let url = URL(string: "https://www.strava.com/oauth/token")!
        let bodyParams: [String: Any] = [
            "client_id": config.clientId,
            "client_secret": config.clientSecret,
            "code": code,
            "grant_type": "authorization_code"
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: bodyParams)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(OAuthToken.self, from: data)
    }

    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return ASPresentationAnchor()
        }
        return window
    }
    
    public func deauthorize() async throws {
        // Clear the token
        tokenStorage.deleteToken()
        
        guard  let oAuthToken = tokenStorage.getToken(), !oAuthToken.isExpired else {
            print("Token already expired")
            return
        }

        // Build the request URL
        guard let url = URL(string: "https://www.strava.com/oauth/deauthorize") else {
            throw NSError(domain: "StravaAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid deauthorize URL"])
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let accessToken = oAuthToken.accessToken else {
            throw StravaAuthError.invalidAccessToken
        }
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["access_token": accessToken])

        // Perform the network request
        let (data, response) = try await URLSession.shared.data(for: request)

        // Check response status
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "StravaAuthManager", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: "Failed to deauthorize the access token."])
        }
    }
}
