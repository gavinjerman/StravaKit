//
//  StravaRepository.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

/// Manages data logic for Strava, including authentication and fetching data
public final class StravaRepository {
    private let authManager: StravaAuthManager
    private let webClient: StravaWebClient

    public init(authManager: StravaAuthManager, webClient: StravaWebClient? = nil) {
        self.authManager = authManager
        self.webClient = webClient ?? StravaWebClient.shared
    }

    /// Fetches all activities for the current athlete
    public func fetchAllActivities(page: Int = 1, perPage: Int = 30) async throws -> [Activity] {
        guard let token = authManager.tokenStorage.getToken() else {
            throw NSError(domain: "StravaRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "No valid token found."])
        }

        // Refresh token if expired
        let validToken = try await authManager.refreshTokenIfNeeded(currentToken: token)
        if validToken.accessToken != token.accessToken {
            authManager.tokenStorage.save(token: validToken)
        }
        // Need to unwrap the accessToken to ensure correct string interpolation
        guard let accessToken = validToken.accessToken, !accessToken.isEmpty else {
            throw NSError(domain: "StravaRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid access token."])
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        do {
            let (data, response) = try await session.data(for: StravaRouter.getActivities(page: 1, perPage: 30).asURLRequest())
            
            // Validate response
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            // Decode response data
            let activities = try JSONDecoder().decode([Activity].self, from: data)
            return activities
        } catch {
            print("DEBUG:: Failed to load activities: \(error)")
            throw error
        }
    }
}
