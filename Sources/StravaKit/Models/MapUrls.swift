//
//  MapUrls.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents map URLs of a route.
public struct MapUrls: Codable {
    /// Standard map URL.
    public let url: String?
    /// Light mode map URL.
    public let lightUrl: String?
    /// Dark mode map URL.
    public let darkUrl: String?
    /// Retina display map URL.
    public let retinaUrl: String?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case url
        case lightUrl = "light_url"
        case darkUrl = "dark_url"
        case retinaUrl = "retina_url"
    }
}
