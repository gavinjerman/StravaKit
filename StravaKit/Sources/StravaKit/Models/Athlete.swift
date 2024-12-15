//
//  File.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents an athlete in Strava.
public struct Athlete: Codable {
    public let id: Int?
    public let username: String?
    public let resourceState: Int?
    public let firstname: String?
    public let lastname: String?
    public let profileMedium: URL?
    public let profile: URL?
    public let city: String?
    public let state: String?
    public let country: String?
    public let sex: String?
    public let friend: String?           // Nullable (represented as "<null>")
    public let follower: String?         // Nullable
    public let premium: Bool?
    public let summit: Bool?             // New field
    public let bio: String?              // New field
    public let weight: Double?
    public let badgeTypeId: Int?
    public let createdAt: String?        // Keep as `String` unless parsing to `Date` is required
    public let updatedAt: String?        // Same as above

    /// Coding keys to map properties to JSON keys
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case resourceState = "resource_state"
        case firstname
        case lastname
        case profileMedium = "profile_medium"
        case profile
        case city
        case state
        case country
        case sex
        case friend
        case follower
        case premium
        case summit
        case bio
        case weight
        case badgeTypeId = "badge_type_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
