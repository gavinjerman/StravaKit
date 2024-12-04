//
//  Activity.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents a detailed or summary activity in Strava.
public struct Activity: Codable, Identifiable {
    public let id: Int
    public let name: String?
    public let description: String?
    public let distance: Double?
    public let movingTime: Int?
    public let elapsedTime: Int?
    public let totalElevationGain: Double?
    public let type: String?
    public let startDate: String?
    public let startDateLocal: String?
    public let timezone: String?
    public let startLatLng: [Double]?
    public let endLatLng: [Double]?
    public let kudosCount: Int?
    public let commentCount: Int?
    public let athleteCount: Int?
    public let photoCount: Int?
    public let map: Map?
    public let trainer: Bool?
    public let commute: Bool?
    public let manual: Bool?
    public let `private`: Bool?
    public let flagged: Bool?
    public let workoutType: Int?
    public let averageSpeed: Double?
    public let maxSpeed: Double?
    public let calories: Double?
    public let hasKudoed: Bool?
    public let averageHeartrate: Double?
    public let maxHeartrate: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, distance
        case movingTime = "moving_time"
        case elapsedTime = "elapsed_time"
        case totalElevationGain = "total_elevation_gain"
        case type
        case startDate = "start_date"
        case startDateLocal = "start_date_local"
        case timezone
        case startLatLng = "start_latlng"
        case endLatLng = "end_latlng"
        case kudosCount = "kudos_count"
        case commentCount = "comment_count"
        case athleteCount = "athlete_count"
        case photoCount = "photo_count"
        case map
        case trainer, commute, manual, `private`, flagged, workoutType
        case averageSpeed = "average_speed"
        case maxSpeed = "max_speed"
        case calories
        case hasKudoed = "has_kudoed"
        case averageHeartrate = "average_heartrate"
        case maxHeartrate = "max_heartrate"
    }
}

/**
 Represents a meta activity with only the unique activity ID.
 */
public final class MetaActivity: Codable {
    public let id: Int?
}
