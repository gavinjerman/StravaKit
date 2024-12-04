//
//  File.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents a specific section of road where athletes’ times are compared, and leaderboards are created.
public struct Segment: Codable {
    /// ID of the segment.
    public let id: Int?
    /// Name of the segment.
    public let name: String?
    /// Description of the segment.
    public let descr: String?
    /// Resource state indicating the level of detail in the segment representation.
    public let resourceState: ResourceState?
    /// Activity type associated with the segment.
    public let activityType: ActivityType?
    /// Distance of the segment in meters.
    public let distance: Double?
    /// Average grade of the segment in percentage.
    public let averageGrade: Double?
    /// Maximum grade of the segment in percentage.
    public let maximumGrade: Double?
    /// Elevation at the highest point of the segment in meters.
    public let elevationHigh: Double?
    /// Elevation at the lowest point of the segment in meters.
    public let elevationLow: Double?
    /// Starting latitude and longitude of the segment.
    public let startLatLng: Location?
    /// Ending latitude and longitude of the segment.
    public let endLatLng: Location?
    /// Climb category of the segment.
    public let climbCategory: Int?
    /// City where the segment is located.
    public let city: String?
    /// State where the segment is located.
    public let state: String?
    /// Country where the segment is located.
    public let country: String?
    /// Indicates if the segment is private.
    public let `private`: Bool?
    /// Indicates if the segment is starred by the athlete.
    public let starred: Bool?
    /// Date when the segment was created.
    public let createdAt: Date?
    /// Date when the segment was last updated.
    public let updateAt: Date?
    /// Total elevation gain of the segment in meters.
    public let totalElevationGain: Double?
    /// Map of the segment.
    public let map: Map?
    /// Number of efforts made on the segment.
    public let effortCount: Int?
    /// Number of athletes who have completed the segment.
    public let athleteCount: Int?
    /// Indicates if the segment is hazardous.
    public let hazardous: Bool?
    /// Number of times the segment has been starred.
    public let starCount: Int?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case descr = "description"
        case resourceState = "resource_state"
        case activityType = "activity_type"
        case distance
        case averageGrade = "average_grade"
        case maximumGrade = "maximum_grade"
        case elevationHigh = "elevation_high"
        case elevationLow = "elevation_low"
        case startLatLng = "start_latlng"
        case endLatLng = "end_latlng"
        case climbCategory = "climb_category"
        case city
        case state
        case country
        case `private`
        case starred
        case createdAt = "created_at"
        case updateAt = "updated_at"
        case totalElevationGain = "total_elevation_gained"
        case map
        case effortCount = "effort_count"
        case athleteCount = "athlete_count"
        case hazardous
        case starCount = "star_count"
    }
}
