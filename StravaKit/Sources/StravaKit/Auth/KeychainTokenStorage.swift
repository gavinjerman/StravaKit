//
//  KeychainTokenStorage.swift
//  
//
//  Created by Gustavo Ferrufino on 2024-11-30.
//

import Foundation
import Security

public final class KeychainTokenStorage: TokenStorage {
    private let keychainKey = "com.strava.oauthToken"

    public init() {}

    public func save(token: OAuthToken) {
        guard let data = try? JSONEncoder().encode(token) else { return }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary) // Ensure no duplicate items
        SecItemAdd(query as CFDictionary, nil)
    }

    public func getToken() -> OAuthToken? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataRef)
        guard status == errSecSuccess, let data = dataRef as? Data else { return nil }
        return try? JSONDecoder().decode(OAuthToken.self, from: data)
    }

    public func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey
        ]
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("Token successfully deleted.")
        } else if status == errSecItemNotFound {
            print("Token not found.")
        } else {
            print("Failed to delete token with status: \(status).")
        }
    }
}
