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
#if os(iOS)
        if let appAuthURL = buildAppAuthURL(), UIApplication.shared.canOpenURL(appAuthURL) {
            await UIApplication.shared.open(appAuthURL)
            return
            // Strava app redirects back with the authorization code; If using UIKit handle it in SceneDelegate/AppDelegate
            // In SwitUI rely on "onOpenURL"
        } else {
            try await authorizeBuildWebAuthURL()
        }
#else
        try await authorizeBuildWebAuthURL()
#endif
    }

    private func authorizeBuildWebAuthURL() async throws {
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
        let request = StravaRouter.exchangeToken(clientId: config.clientId, clientSecret: config.clientSecret, code: code).asURLRequest()
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(OAuthToken.self, from: data)
    }

    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
#if os(iOS)
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return ASPresentationAnchor()
        }
        return window
#else
        // return the main window
        if let window = NSApplication.shared.windows.first {
            return window
        }
        return ASPresentationAnchor()
#endif
    }
    
    public func deauthorize() async throws {
        // Clear the token
        tokenStorage.deleteToken()
        
        guard  let oAuthToken = tokenStorage.getToken(), !oAuthToken.isExpired else {
            print("Token already expired")
            return
        }

        guard let accessToken = oAuthToken.accessToken else {
            throw StravaAuthError.invalidAccessToken
        }
        let request = StravaRouter.deauthorize(accessToken: accessToken).asURLRequest()

        // Perform the network request
        let (_, response) = try await URLSession.shared.data(for: request)

        // Check response status
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "StravaAuthManager", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey: "Failed to deauthorize the access token."])
        }
    }
}
