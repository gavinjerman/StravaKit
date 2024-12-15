//
//  Activity.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation
import CoreLocation

/// Represents a detailed or summary activity in Strava.
public struct Activity: Codable, Identifiable, Hashable {
    
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
    
    public static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Activity {
    public var formattedDistance: String {
        let distanceInKm = (distance ?? 0) / 1000
        return String(format: "%.0f km", distanceInKm)
    }

    public var formattedElevation: String {
        let elevation = totalElevationGain ?? 0
        return String(format: "%.0f m", elevation)
    }

    public var typeIconName: String {
        switch type?.lowercased() {
        case "ride": return "figure.outdoor.cycle"
        case "run": return "figure.run"
        case "trail": return "figure.hiking"
        default: return "figure.wave"
        }
    }
}

/**
 Represents a meta activity with only the unique activity ID.
 */
public final class MetaActivity: Codable {
    public let id: Int?
}

extension Activity: StravaItem {
    
    // Activity only fills summaryPolyline
    public func decodePolyline() -> [CLLocationCoordinate2D]? {
        guard let polyline = map?.summaryPolyline else { return nil }
        var coordinates: [CLLocationCoordinate2D] = []
        var index = polyline.startIndex
        let end = polyline.endIndex
        var lat = 0
        var lng = 0

        while index < end {
            var byte = 0
            var shift = 0
            var result = 0
            repeat {
                byte = Int(polyline[index].asciiValue! - 63)
                index = polyline.index(after: index)
                result |= (byte & 0x1F) << shift
                shift += 5
            } while byte >= 0x20
            let deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1))
            lat += deltaLat

            shift = 0
            result = 0
            repeat {
                byte = Int(polyline[index].asciiValue! - 63)
                index = polyline.index(after: index)
                result |= (byte & 0x1F) << shift
                shift += 5
            } while byte >= 0x20
            let deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1))
            lng += deltaLng

            coordinates.append(CLLocationCoordinate2D(latitude: Double(lat) / 1E5, longitude: Double(lng) / 1E5))
        }

        return coordinates
    }
}
