//
//  Stream.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents the raw data (streams) associated with an activity or segment effort in Strava.
/// All streams for a given activity or segment effort will be the same length, and the values at a given index correspond to the same time.
public struct Stream: Codable {
    /// Type of the stream (e.g., time, distance, altitude).
    public let type: StreamType?
    /// The raw data of the stream.
    public let data: [Double]?
    /// The series type of the stream (e.g., distance, time).
    public let seriesType: String?
    /// The original size of the stream data.
    public let originalSize: Int?
    /// The resolution of the stream (e.g., low, medium, high).
    public let resolution: ResolutionType?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case type
        case data
        case seriesType = "series_type"
        case originalSize = "original_size"
        case resolution
    }
}
