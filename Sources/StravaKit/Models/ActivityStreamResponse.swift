//
//  ActivityStreamResponse.swift
//  StravaKit
//
//  Created by Gustavo Ferrufino on 2024-12-25.
//


import Foundation

// MARK: - Activity Stream Response
public struct ActivityStreamResponse: Codable {
    public let time: TimeStream?
    public let distance: DistanceStream?
    public let latlng: LatLngStream?
    public let altitude: AltitudeStream?
    public let velocitySmooth: SmoothVelocityStream?
    public let heartrate: HeartrateStream?
    public let cadence: CadenceStream?
    public let watts: PowerStream?
    public let temp: TemperatureStream?
    public let moving: MovingStream?
    public let gradeSmooth: SmoothGradeStream?
}
