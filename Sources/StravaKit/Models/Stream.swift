//
//  Stream 2.swift
//  StravaKit
//
//  Created by Gustavo Ferrufino on 2024-12-25.
//


import Foundation

// Base Stream Model
public struct Stream<T: Codable>: Codable {
    let type: String?
    let data: [T?]?
    let originalSize: Int?
    let resolution: String?
    let seriesType: String?
    
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

// StreamSet to encapsulate all possible streams
public struct StreamSet: Codable {
    let time: TimeStream?
    let distance: DistanceStream?
    let latlng: LatLngStream?
    let altitude: AltitudeStream?
    let velocitySmooth: SmoothVelocityStream?
    let heartrate: HeartrateStream?
    let cadence: CadenceStream?
    let watts: PowerStream?
    let temp: TemperatureStream?
    let moving: MovingStream?
    let gradeSmooth: SmoothGradeStream?
    
    enum CodingKeys: String, CodingKey {
           case time
           case distance
           case latlng
           case altitude
           case velocitySmooth = "velocity_smooth"
           case heartrate
           case cadence
           case watts
           case temp
           case moving
           case gradeSmooth = "grade_smooth"
       }
}
