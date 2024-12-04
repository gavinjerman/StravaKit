//
//  File.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents the OAuth token required for Strava API requests.
public struct OAuthToken: Codable {
    public let tokenType: String?
    public let expiresAt: Int?        // Epoch timestamp when token expires
    public let expiresIn: Int?       // Seconds until expiration
    public let refreshToken: String? // Refresh token for renewal
    public let accessToken: String?  // Access token for API calls
    public let athlete: Athlete?     // Summary athlete information

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresAt = "expires_at"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case athlete
    }
}

extension OAuthToken {
    
    /// Checks if the token is expired.
    public var isExpired: Bool {
        guard let expiresAt = expiresAt else { return true }
        let currentTimestamp = Int(Date().timeIntervalSince1970)
        return currentTimestamp >= expiresAt
    }

    /// Provides the remaining time in seconds until the token expires.
    public var timeUntilExpiration: Int? {
        guard let expiresAt = expiresAt else { return nil }
        let currentTimestamp = Int(Date().timeIntervalSince1970)
        return max(0, expiresAt - currentTimestamp)
    }
}
