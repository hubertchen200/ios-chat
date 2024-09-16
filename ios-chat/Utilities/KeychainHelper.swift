//
//  KeychainHelper.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/15/24.
//

import Foundation

import Security

class KeychainHelper {

    // MARK: - Save Data to Keychain
    static func save(_ data: Data, service: String, account: String) {
        // Create a query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        // Delete any existing item
        SecItemDelete(query as CFDictionary)
        
        // Add new keychain item
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Error saving data to Keychain: \(status)")
        }
    }

    // MARK: - Retrieve Data from Keychain
    static func retrieve(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            return result as? Data
        } else {
            print("Error retrieving data from Keychain: \(status)")
            return nil
        }
    }

    // MARK: - Delete Data from Keychain
    static func delete(service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            print("Error deleting data from Keychain: \(status)")
        }
    }
}
