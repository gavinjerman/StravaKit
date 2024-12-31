//
//  RouteStreamResponse.swift
//  StravaKit
//
//  Created by Gustavo Ferrufino on 2024-12-25.
//


import Foundation

// MARK: - Route Stream Response
public struct RouteStreamResponse: Codable {
    public let time: TimeStream?
    public let distance: DistanceStream?
    public let latlng: LatLngStream?
    public let altitude: AltitudeStream?
    public let gradeSmooth: SmoothGradeStream?

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var time: TimeStream?
        var distance: DistanceStream?
        var latlng: LatLngStream?
        var altitude: AltitudeStream?
        var gradeSmooth: SmoothGradeStream?

        while !container.isAtEnd {
            let base = try container.decode(BaseStream.self)
            switch base.type {
            case "time":
                time = try base.decode(as: TimeStream.self)
            case "distance":
                distance = try base.decode(as: DistanceStream.self)
            case "latlng":
                latlng = try base.decode(as: LatLngStream.self)
            case "altitude":
                altitude = try base.decode(as: AltitudeStream.self)
            case "grade_smooth":
                gradeSmooth = try base.decode(as: SmoothGradeStream.self)
            default:
                // Ignore stream types we don't care about
                break
            }
        }

        self.time = time
        self.distance = distance
        self.latlng = latlng
        self.altitude = altitude
        self.gradeSmooth = gradeSmooth
    }
}

// MARK: - Helper for dynamic decoding
private struct BaseStream: Decodable {
    let type: String
    let rawData: Data

    enum CodingKeys: String, CodingKey {
        case type
        case data
        case originalSize = "original_size"
        case resolution
        case seriesType = "series_type"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)

        // Try possible array shapes for 'data'
        if let ints = try? container.decode([Int].self, forKey: .data) {
            rawData = try JSONEncoder().encode(
                Stream(type: type, data: ints.map { $0 }, originalSize: nil, resolution: nil, seriesType: nil)
            )
        } else if let doubles = try? container.decode([Double].self, forKey: .data) {
            rawData = try JSONEncoder().encode(
                Stream(type: type, data: doubles.map { $0 }, originalSize: nil, resolution: nil, seriesType: nil)
            )
        } else if let coords = try? container.decode([[Double]].self, forKey: .data) {
            rawData = try JSONEncoder().encode(
                Stream(type: type, data: coords.map { $0 }, originalSize: nil, resolution: nil, seriesType: nil)
            )
        } else if let bools = try? container.decode([Bool].self, forKey: .data) {
            rawData = try JSONEncoder().encode(
                Stream(type: type, data: bools.map { $0 }, originalSize: nil, resolution: nil, seriesType: nil)
            )
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .data,
                in: container,
                debugDescription: "Unsupported data type for stream '\(type)'."
            )
        }
    }

    func decode<T: Decodable>(as streamType: T.Type) throws -> T {
        return try JSONDecoder().decode(streamType, from: rawData)
    }
}
