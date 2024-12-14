//
//  DIContainer.swift
//  StravaKitDemo
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import Foundation
import StravaKit

final class DIContainer {
    let stravaRepository: StravaRepository
    let stravaService: StravaService
    let stravaAuthManager: StravaAuthManager
    
    init() {
        // Initialize dependencies here
        let config = StravaConfig(
            clientId: "",
            clientSecret: "",
            redirectUri: "",
            scopes: ""
        )
        let tokenStorage = KeychainTokenStorage()
        let authManager = StravaAuthManager(config: config, tokenStorage: tokenStorage)
        let repository = StravaRepository(authManager: authManager)
        
        self.stravaAuthManager = authManager
        self.stravaRepository = repository
        self.stravaService = StravaService(repository: repository)
    }
}
