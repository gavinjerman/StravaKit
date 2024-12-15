//
//  StravaError.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

public enum StravaError: Error, LocalizedError {
    case missingAccessToken
    case missingAuthCode
    case tokenRefreshFailed
    case invalidResponse

    public var errorDescription: String? {
        switch self {
        case .missingAccessToken:
            return "Access token is missing. Please authorize first."
        case .missingAuthCode:
            return "Authorization code is missing."
        case .tokenRefreshFailed:
            return "Failed to refresh access token."
        case .invalidResponse:
            return "The server returned an invalid response."
        }
    }
}
