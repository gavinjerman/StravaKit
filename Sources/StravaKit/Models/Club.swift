//
//  Club.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents a group of athletes on Strava. Clubs can be public or private and are returned in summary or detailed representations.
public struct Club: Codable {
    /// Club ID.
    public let id: Int?
    /// URL for the medium-sized profile image of the club.
    public let profileMedium: URL?
    /// URL for the profile image of the club.
    public let profile: URL?
    /// Name of the club.
    public let name: String?
    /// Description of the club.
    public let description: String?
    /// City where the club is located.
    public let city: String?
    /// State where the club is located.
    public let state: String?
    /// Country where the club is located.
    public let country: String?
    /// Type of the club (e.g., casual club, racing team).
    public let clubType: ClubType?
    /// Sport type associated with the club (e.g., cycling, running).
    public let sportType: SportType?
    /// Indicates whether the club is private.
    public let isPrivate: Bool?
    /// Total number of members in the club.
    public let memberCount: Int?
    /// The resource state indicating the level of detail in the club representation.
    public let resourceState: ResourceState?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case id
        case profileMedium = "profile_medium"
        case profile
        case name
        case description
        case city
        case state
        case country
        case clubType = "club_type"
        case sportType = "sport_type"
        case isPrivate = "private"
        case memberCount = "member_count"
        case resourceState = "resource_state"
    }
}
