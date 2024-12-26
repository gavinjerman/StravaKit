//
//  ActivityStreamResponse.swift
//  StravaKit
//
//  Created by Gustavo Ferrufino on 2024-12-25.
//


import Foundation

// MARK: - Activity Stream Response
public struct ActivityStreamResponse: Codable {
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
