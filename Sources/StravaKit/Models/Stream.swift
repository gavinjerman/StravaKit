//
//  Stream 2.swift
//  StravaKit
//
//  Created by Gustavo Ferrufino on 2024-12-25.
//


import Foundation

// Base Stream Model
public struct Stream<T: Codable>: Codable {
    public let type: String?
    public let data: [T?]?
    public let originalSize: Int?
    public let resolution: String?
    public let seriesType: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
        case originalSize = "original_size"
        case resolution
        case seriesType = "series_type"
    }
}

// Specific Stream Types
public typealias TimeStream = Stream<Int>
public typealias DistanceStream = Stream<Double>
public typealias LatLngStream = Stream<[Double]>
public typealias AltitudeStream = Stream<Double>
public typealias SmoothVelocityStream = Stream<Double>
public typealias HeartrateStream = Stream<Int>
public typealias CadenceStream = Stream<Int>
public typealias PowerStream = Stream<Int>
public typealias TemperatureStream = Stream<Int>
public typealias MovingStream = Stream<Bool>
public typealias SmoothGradeStream = Stream<Double>
