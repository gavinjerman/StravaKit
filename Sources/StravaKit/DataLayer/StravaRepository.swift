//
//  StravaRepository.swift
// Fetch/Save/Update and delete
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

/// Custom error for StravaRepository
enum StravaRepositoryError: Error, LocalizedError {
    case noToken

    var errorDescription: String? {
        switch self {
        case .noToken:
            return "No valid token found."
        }
    }
}

public final class StravaRepository {
    private let authManager: StravaAuthManager
    private let webClient: StravaWebClient

    public init(authManager: StravaAuthManager, webClient: StravaWebClient? = nil) {
        self.authManager = authManager
        self.webClient = webClient ?? StravaWebClient.shared
    }

    // MARK: - Public Methods

    public func fetchAllActivities(page: Int = 1, perPage: Int = 30) async throws -> [Activity] {
        return try await webClient.performRequest(
            with: StravaRouter.getActivities(page: page, perPage: perPage).asURLRequest(),
            token: authManager.getValidToken(),
            responseType: [Activity].self
        )
    }

    public func fetchSavedRoutes(page: Int = 1, perPage: Int = 30) async throws -> [Route] {
        return try await webClient.performRequest(
            with: StravaRouter.getSavedRoutes(page: page, perPage: perPage).asURLRequest(),
            token: authManager.getValidToken(),
            responseType: [Route].self
        )
    }

    public func logout() async throws {
        try await authManager.deauthorize()
    }

    // MARK: - Private Methods

    /// Refresh token if needed
    private func refreshTokenIfNeeded() async throws -> OAuthToken {
        guard let currentToken = authManager.tokenStorage.getToken() else {
            throw StravaRepositoryError.noToken
        }
        return try await authManager.refreshTokenIfNeeded(currentToken: currentToken)
    }
}
