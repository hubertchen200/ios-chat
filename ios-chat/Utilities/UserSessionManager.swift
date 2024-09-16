//
//  UserSessionManager.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/15/24.
//

import Foundation
import Security

class UserSessionManager {

    private static let service = "site.hubertchen200.service"
    private static let account = "userSession"
    
    // Save UserSession data to Keychain
    static func save(session: UserSession) {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(session)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecValueData as String: data
            ]
            
            // Delete any existing data before saving
            SecItemDelete(query as CFDictionary)
            
            // Add new keychain item
            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                print("Error saving user session to Keychain: \(status)")
            } else {
                print("User session saved successfully.")
            }
            
        } catch {
            print("Error encoding UserSession: \(error)")
        }
    }
    
    // Retrieve UserSession data from Keychain
    static func retrieve() -> UserSession? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            let decoder = JSONDecoder()
            
            do {
                let session = try decoder.decode(UserSession.self, from: data)
                return session
            } catch {
                print("Error decoding UserSession: \(error)")
                return nil
            }
        } else {
            print("Error retrieving user session from Keychain: \(status)")
            return nil
        }
    }
    
    // Delete UserSession data from Keychain
    static func delete() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("User session deleted from Keychain.")
        } else {
            print("Error deleting user session from Keychain: \(status)")
        }
    }
}
