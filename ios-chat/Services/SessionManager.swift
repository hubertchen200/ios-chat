//
//  SessionManager.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/28/24.
//

import Foundation

class SessionManager {
    
    // Shared instance (singleton)
    static let shared = SessionManager()
    
    // Session properties
    private(set) var userData: UserData?
    private(set) var token: String?
    
    
    // Private initializer to prevent others from creating instances
    private init() { }
    
    // Method to save session data
    func saveSession(userData: UserData?, token: String?) {
        guard let userData = userData, let token = token else {
            print("user data or token is missing")
            return
        }
        self.userData = userData
        self.token = token
    }
    
    // Method to clear session data
    func clearSession() {
        self.userData = nil
        self.token = nil
       
    }
}
