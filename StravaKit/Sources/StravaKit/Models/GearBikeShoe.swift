//
//  GearBikeShoe.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Represents gear used during an activity. The object is returned in summary or detailed representations.
open class Gear: Codable {
    /// ID of the gear.
    public let id: String?
    /// Indicates whether this is the primary gear.
    public let primary: Bool?
    /// Name of the gear.
    public let name: String?
    /// Description of the gear.
    public let description: String?
    /// The resource state indicating the level of detail in the gear representation.
    public let resourceState: ResourceState?
    /// Total distance covered by the gear (in meters).
    public let distance: Double?
    /// Brand name of the gear.
    public let brandName: String?
    /// Model name of the gear.
    public let modelName: String?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case id
        case primary
        case name
        case description
        case resourceState = "resource_state"
        case distance
        case brandName = "brand_name"
        case modelName = "model_name"
    }
}

/**
 Represents shoes worn during a run. The object is returned in summary or detailed representations.
 */
public final class Shoe: Gear {}

/**
 Represents a bike used during an activity. The object is returned in summary or detailed representations.
 */
public final class Bike: Gear {
    /// Frame type of the bike.
    public let frameType: FrameType?

    /// Coding keys to map properties to JSON keys.
    private enum CodingKeys: String, CodingKey {
        case frameType = "frame_type"
    }

    /// Decoding initializer.
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        frameType = try container.decodeIfPresent(FrameType.self, forKey: .frameType)
        try super.init(from: decoder)
    }

    /// Encoding function for Encodable.
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(frameType, forKey: .frameType)
        try super.encode(to: encoder)
    }
}
