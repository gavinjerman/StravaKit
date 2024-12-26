//
//  Stream 2.swift
//  StravaKit
//
//  Created by Gustavo Ferrufino on 2024-12-25.
//


import Foundation

// Base Stream Model
public struct Stream<T: Codable>: Codable {
    let type: String
    let data: [T]
    let originalSize: Int
    let resolution: String
    let seriesType: String
}

// Specific Stream Types
typealias TimeStream = Stream<Int>
typealias DistanceStream = Stream<Double>
typealias LatLngStream = Stream<[Double]>
typealias AltitudeStream = Stream<Double>
typealias SmoothVelocityStream = Stream<Double>
typealias HeartrateStream = Stream<Int>
typealias CadenceStream = Stream<Int>
typealias PowerStream = Stream<Int>
typealias TemperatureStream = Stream<Int>
typealias MovingStream = Stream<Bool>
typealias SmoothGradeStream = Stream<Double>

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
}
