//
//  StravaRepository.swift
// Fetch/Save/Update and delete
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

/// Custom error for StravaRepository
enum StravaRepositoryError: Error, LocalizedError {
    case noAccessToken

    var errorDescription: String? {
        switch self {
        case .noAccessToken:
            return "No valid Access Token found."
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
    
    /// Types: ["time", "distance", "latlng", "altitude", "velocity_smooth", "heartrate", "cadence", "watts", "temp", "moving", "grade_smooth"]
    public func fetchActivityStream(activityId: String, token: OAuthToken, types: [String]) async throws -> ActivityStreamResponse {
        let router = StravaRouter.getActivityStreams(
            activityId: activityId,
            types: types
        )
        let request = router.asURLRequest()
        return try await StravaWebClient.shared.performRequest(
            with: request,
            token: token,
            responseType: ActivityStreamResponse.self
        )
    }
    
    public func fetchRouteStream(routeId: String, token: OAuthToken) async throws -> RouteStreamResponse {
        let router = StravaRouter.getRouteStreams(routeId: routeId)
        let request = router.asURLRequest()
        return try await StravaWebClient.shared.performRequest(
            with: request,
            token: token,
            responseType: RouteStreamResponse.self
        )
    }
}
