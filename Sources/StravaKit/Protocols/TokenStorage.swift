//
//  File.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation

public protocol TokenStorage {
    func save(token: OAuthToken)
    func getToken() -> OAuthToken?
    func deleteToken()
}
