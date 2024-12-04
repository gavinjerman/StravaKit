//
//  StravaWebClient.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

/// Handles Strava API network requests
public final class StravaWebClient {
    public static let shared = StravaWebClient()
    private init() {}

    /// Perform a network request using the given StravaRouter
    func perform<T: Decodable>(_ route: StravaRouter, responseType: T.Type) async throws -> T {
        let request = route.asURLRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        print("DEBUG:: Raw Response Data: \(String(data: data, encoding: .utf8) ?? "No Response Data")")
        print("DEBUG:: HTTP Response: \(response)")

        // Validate HTTP response
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let serverMessage = String(data: data, encoding: .utf8) ?? "No additional error info"
            throw NSError(domain: "StravaWebClientError", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: [NSLocalizedDescriptionKey: "Invalid server response \(serverMessage)"])
        }

        // Decode response
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            print("DEBUG:: decodedResponse")
            return decodedResponse
        } catch {
            throw NSError(domain: "StravaWebClientError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response: \(error.localizedDescription)"])
        }
    }
}
