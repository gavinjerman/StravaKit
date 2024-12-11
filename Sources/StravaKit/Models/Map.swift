//
//  Map.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents a map of a ride or route.
public struct Map: Codable, Hashable {
    /// The ID of the map.
    public let id: String?
    /// The resource state indicating the level of detail in the map representation.
    public let resourceState: ResourceState?
    /// The detailed polyline of the map.
    public let polyline: String?
    /// The summary polyline of the map.
    public let summaryPolyline: String?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case id
        case resourceState = "resource_state"
        case polyline
        case summaryPolyline = "summary_polyline"
    }
}
