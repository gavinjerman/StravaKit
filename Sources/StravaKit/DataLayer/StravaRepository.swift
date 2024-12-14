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
    private let webClient: StravaWebClient

    public init(webClient: StravaWebClient? = nil) {
        self.webClient = webClient ?? StravaWebClient.shared
    }

    // MARK: - Public Methods

    public func fetchAllActivities(token: OAuthToken, page: Int = 1, perPage: Int = 30) async throws -> [Activity] {
        return try await webClient.performRequest(
            with: StravaRouter.getActivities(page: page, perPage: perPage).asURLRequest(),
            token: token,
            responseType: [Activity].self
        )
    }

    public func fetchSavedRoutes(token: OAuthToken, page: Int = 1, perPage: Int = 30) async throws -> [Route] {
        return try await webClient.performRequest(
            with: StravaRouter.getSavedRoutes(page: page, perPage: perPage).asURLRequest(),
            token: token,
            responseType: [Route].self
        )
    }
}
