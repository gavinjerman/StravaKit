//
//  StravaService.swift
//
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import Foundation
import StravaKit

/// Business logic processing for Strava API
public final class StravaService {
    private let repository: StravaRepository
    private let authManager: StravaAuthManager
    
    // MARK: Request Methods
    /// Initialize with a repository
    public init(repository: StravaRepository, authManager: StravaAuthManager) {
        self.repository = repository
        self.authManager = authManager
    }

    /// Fetch all activities
    public func fetchActivities(page: Int = 1, perPage: Int = 30) async throws -> [Activity] {
        print("DEBUG:: StravaService fetching activities")
        let token = try await authManager.getValidToken()
        print("DEBUG:: StravaService token retrieved, isExpired? \(token.isExpired), Token \(token)")
        return try await repository.fetchAllActivities(token: token, page: page, perPage: perPage)
    }

    /// Fetch all saved routes
    public func fetchSavedRoutes(page: Int = 1, perPage: Int = 30) async throws -> [Route] {
        print("DEBUG:: StravaService fetching activities")
        let token = try await authManager.getValidToken()
        print("DEBUG:: StravaService token retrieved, isExpired? \(token.isExpired), Token \(token)")
        return try await repository.fetchSavedRoutes(token: token, page: page, perPage: perPage)
    }
    
    // MARK: Autentication Methods
    public func login() async {
        try? await authManager.authorize()
    }
    
    public func logout() async {
        try? await authManager.deauthorize()
    }
    
    public func handleAuthResponse(url: URL) async throws -> OAuthToken {
        return try await authManager.handleAuthResponse(url: url)
    }
    
    public func isAuthenticated() async -> Bool {
        return await authManager.authenticated()
    }
}
