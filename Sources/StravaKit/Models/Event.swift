//
//  Event.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents group events that are optionally recurring for club members. Only club members can access private club events.
/// The objects are returned in summary representation.
public struct Event: Codable {
    /// Event ID.
    public let id: Int?
    /// The resource state indicating the level of detail in the event representation.
    public let resourceState: ResourceState?
    /// Title of the event.
    public let title: String?
    /// Description of the event.
    public let descr: String?
    /// ID of the club organizing the event.
    public let clubId: Int?
    /// Athlete organizing the event.
    public let organizingAthlete: Athlete?
    /// Type of activity associated with the event.
    public let activityType: ActivityType?
    /// Date and time when the event was created.
    public let createdAt: Date?
    /// ID of the route associated with the event.
    public let routeId: Int?
    /// Indicates if the event is for women only.
    public let womenOnly: Bool?
    /// Indicates if the event is private.
    public let `private`: Bool?
    /// Skill level required for the event.
    public let skillLevels: SkillLevel?
    /// Terrain type of the event.
    public let terrain: Terrain?
    /// Upcoming occurrences of the event.
    public let upcomingOccurrences: [Date]?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case id
        case resourceState = "resource_state"
        case title
        case descr = "description"
        case clubId = "club_id"
        case organizingAthlete = "organizing_athlete"
        case activityType = "activity_type"
        case createdAt = "created_at"
        case routeId = "route_id"
        case womenOnly = "women_only"
        case `private`
        case skillLevels = "skill_level"
        case terrain
        case upcomingOccurrences = "upcoming_occurrences"
    }
}
