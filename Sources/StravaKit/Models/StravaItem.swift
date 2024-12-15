//
//  StravaItem.swift
//
//
//  Created by Gustavo Ferrufino on 2024-12-10.
//

import Foundation
import CoreLocation

public protocol StravaItem {
    var name: String? { get }
    var typeIconName: String { get }
    var formattedDistance: String { get }
    var formattedElevation: String { get }
    func decodePolyline() -> [CLLocationCoordinate2D]?
}
