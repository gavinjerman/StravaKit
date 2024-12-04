//
//  StravaConfig.swift
//
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

public struct StravaConfig {
    public let clientId: String
    public let clientSecret: String
    public let redirectUri: String
    public let scopes: String
    public let forcePrompt: Bool

    public init(clientId: String, clientSecret: String, redirectUri: String, scopes: String, forcePrompt: Bool = true) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectUri = redirectUri
        self.scopes = scopes
        self.forcePrompt = forcePrompt
    }
}
