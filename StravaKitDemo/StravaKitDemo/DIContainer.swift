//
//  DIContainer.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import Foundation
import StravaKit

final class DIContainer {
    let stravaService: StravaService
    
    init() {
        // Initialize dependencies here
        let config = StravaConfig(
            clientId: "122144",
            clientSecret: "900e99a9a6a4d7ca494729af491f0ad9225f147c",
            redirectUri: "trailcast://outdoorsy.cc",
            scopes: "read,activity:write,activity:read_all"
        )
        let tokenStorage = KeychainTokenStorage()
        let authManager = StravaAuthManager(config: config, tokenStorage: tokenStorage)
        let repository = StravaRepository()

        self.stravaService = StravaService(repository: repository, authManager: authManager)
    }
}
