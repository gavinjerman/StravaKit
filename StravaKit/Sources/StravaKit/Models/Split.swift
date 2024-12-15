//
//  Split.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents a summary of a split.
public struct Split: Codable {
    /// Distance covered in the split (in meters).
    public let distance: Double?
    /// Total elapsed time for the split (in seconds).
    public let elapsedTime: Int?
    /// Moving time for the split (in seconds).
    public let movingTime: Int?
    /// Elevation difference for the split (in meters).
    public let elevationDifference: Int?
    /// Split number.
    public let split: Int?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case distance
        case elapsedTime = "elapsed_time"
        case movingTime = "moving_time"
        case elevationDifference = "elevation_difference"
        case split
    }
}
