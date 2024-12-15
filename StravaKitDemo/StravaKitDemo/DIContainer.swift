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
            clientId: "",
            clientSecret: "",
            redirectUri: "",
            scopes: "read,activity:write,activity:read_all"
        )
        let tokenStorage = KeychainTokenStorage()
        let authManager = StravaAuthManager(config: config, tokenStorage: tokenStorage)
        let repository = StravaRepository()

        self.stravaService = StravaService(repository: repository, authManager: authManager)
    }
}
