//
//  RouteStreamResponse.swift
//  StravaKit
//
//  Created by Gustavo Ferrufino on 2024-12-25.
//


import Foundation

// MARK: - Route Stream Response
public struct RouteStreamResponse: Codable {
    let time: TimeStream?
    let distance: DistanceStream?
    let latlng: LatLngStream?
    let altitude: AltitudeStream?
    let gradeSmooth: SmoothGradeStream?
}
