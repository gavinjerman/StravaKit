//
//  StravaWebClient.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

enum StravaWebClientError: Error, LocalizedError {
    case invalidAccessToken
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .invalidAccessToken:
            return "Invalid access token."
        case .networkError(let message):
            return "Network error: \(message)"
        }
    }
}

/// Handles Strava API network requests
public final class StravaWebClient {
    public static let shared = StravaWebClient()
    private init() {}

    /// Perform a network request using the given StravaRouter
    public func performRequest<T: Decodable>(
        with request: URLRequest,
        token: OAuthToken,
        responseType: T.Type
    ) async throws -> T {
        do {
            let session = try await createAuthorizedSession(token)
            let (data, response) = try await session.data(for: request)
            try validateResponse(response)
            return try JSONDecoder().decode(responseType, from: data)
        } catch let error as DecodingError {
            throw error
        } catch {
            throw StravaWebClientError.networkError(error.localizedDescription)
        }
    }
    
    /// Validates the HTTP response
    private func validateResponse(_ response: URLResponse) throws {
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw StravaWebClientError.networkError("HTTP Status Code: \(httpResponse.statusCode)")
        }
    }
    
    /// Creates a URLSession with an authorized access token
    private func createAuthorizedSession(_ token: OAuthToken) async throws -> URLSession {
        guard let accessToken = token.accessToken, !accessToken.isEmpty else {
            throw StravaWebClientError.invalidAccessToken
        }

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
        return URLSession(configuration: sessionConfig)
    }
}
