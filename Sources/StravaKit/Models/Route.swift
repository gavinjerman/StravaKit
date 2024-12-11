//
//  Route.swift
//
//
//  Created by Gustavo Ferrufino on 2024-12-05.
//

import Foundation
import CoreLocation

/// Represents a saved route in Strava
public struct Route: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String?
    public let description: String?
    public let distance: Double
    public let elevationGain: Double
    public let type: Int // Route type (e.g., "ride", "run")
    public let map: Map?

    enum CodingKeys: String, CodingKey {
        case id, name, description, distance
        case elevationGain = "elevation_gain"
        case type = "type"
        case map
    }
    
    public static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.id == rhs.id
    }
}

extension Route {
    public var formattedDistance: String {
        let distanceInKm = distance / 1000
        return String(format: "%.0f km", distanceInKm)
    }

    public var formattedElevation: String {
        String(format: "%.0f m", elevationGain)
    }

    public var typeIconName: String {
        switch type {
        case 1: return "figure.outdoor.cycle"
        case 2: return "figure.run"
        case 4: return "figure.hiking"
        default: return "figure.wave"
        }
    }
}

extension Route: StravaItem {
    // Route only fills summaryPolyline
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
