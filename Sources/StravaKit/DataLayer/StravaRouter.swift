//
//  StravaRouter.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

/// Enum defining all possible Strava API routes
public enum StravaRouter {
    case authorizeApp(clientId: String, redirectUri: String, scopes: String, approvalPrompt: String)
    case exchangeToken(clientId: String, clientSecret: String, code: String)
    case getActivities(page: Int, perPage: Int)
    case refreshToken(clientId: String, clientSecret: String, refreshToken: String)
    case deauthorize(accessToken: String)

    /// Base URL for Strava API
    private var baseURL: URL {
        switch self {
        case .authorizeApp:
            return URL(string: "strava://oauth/mobile/authorize")!
        case .exchangeToken, .refreshToken, .getActivities, .deauthorize:
            return URL(string: "https://www.strava.com/api/v3")!
        }
    }

    /// Path for the route
    private var path: String {
        switch self {
        case .authorizeApp:
            return ""
        case .exchangeToken, .refreshToken:
            return "/oauth/token"
        case .getActivities:
            return "/athlete/activities"
        case .deauthorize:
            return "/oauth/deauthorize"
        }
    }

    /// HTTP method
    private var method: String {
        switch self {
        case .authorizeApp:
            return "GET"
        case .exchangeToken, .refreshToken, .deauthorize:
            return "POST"
        case .getActivities:
            return "GET"
        }
    }

    /// Query items for the route
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .authorizeApp(let clientId, let redirectUri, let scopes, let approvalPrompt):
            return [
                URLQueryItem(name: "client_id", value: clientId),
                URLQueryItem(name: "redirect_uri", value: redirectUri),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope", value: scopes),
                URLQueryItem(name: "approval_prompt", value: approvalPrompt)
            ]
        case .exchangeToken(let clientId, let clientSecret, let code):
            return nil // POST request, body handled separately
        case .refreshToken(let clientId, let clientSecret, let refreshToken):
            return nil // POST request, body handled separately
        case .getActivities(let page, let perPage):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        case .deauthorize:
            return nil
        }
    }

    /// HTTP body for POST requests
    private var body: Data? {
        switch self {
        case .exchangeToken(let clientId, let clientSecret, let code):
            return try? JSONSerialization.data(withJSONObject: [
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code,
                "grant_type": "authorization_code"
            ])
        case .refreshToken(let clientId, let clientSecret, let refreshToken):
            return try? JSONSerialization.data(withJSONObject: [
                "client_id": clientId,
                "client_secret": clientSecret,
                "grant_type": "refresh_token",
                "refresh_token": refreshToken
            ])
        case .deauthorize(let accessToken):
            return try? JSONSerialization.data(withJSONObject: [
                "access_token": accessToken
            ])
        default:
            return nil
        }
    }

    /// Builds the URL request
    public func asURLRequest() -> URLRequest {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path.append(path)

        if method == "GET" {
            components?.queryItems = queryItems
        }

        var request = URLRequest(url: components?.url ?? baseURL)
        request.httpMethod = method

        if method == "POST", let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}
