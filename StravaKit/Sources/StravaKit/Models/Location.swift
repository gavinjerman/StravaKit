//
//  Location.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents the latitude and longitude of a point.
public struct Location: Codable {
    /// Latitude of the location.
    public let lat: Double?
    /// Longitude of the location.
    public let lng: Double?
}
