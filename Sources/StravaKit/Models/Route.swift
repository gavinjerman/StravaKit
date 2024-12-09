//
//  Route.swift
//
//
//  Created by Gustavo Ferrufino on 2024-12-05.
//

import Foundation

/// Represents a saved route in Strava
public struct Route: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let description: String?
    public let distance: Double
    public let elevationGain: Double
    public let type: Int // Route type (e.g., "ride", "run")
    public let map: MapUrls?

    public struct MapUrls: Codable, Hashable {
        public let id: String
        public let polyline: String?
        public let summaryPolyline: String?
    }

    enum CodingKeys: String, CodingKey {
        case id, name, description, distance
        case elevationGain = "elevation_gain"
        case type = "type"
        case map
    }
}

extension Route {
    public var formattedDistance: String {
        let distanceInKm = distance / 1000
        return String(format: "%.2f km", distanceInKm)
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
