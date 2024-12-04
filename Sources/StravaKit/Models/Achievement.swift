//
//  Achievement.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-28.
//

import Foundation

/// Achievement struct - details the type of achievement and the rank
public struct Achievement: Codable, CustomStringConvertible {
    /// Achievement type enum
    public let type: AchievementType?

    /// Rank for the achievement
    public let rank: Int?

    /// Default implementation of description for debugging
    public var description: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(self),
           let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        }
        return "Unable to describe object."
    }
}
