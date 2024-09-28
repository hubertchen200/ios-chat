//
//  ProfileViewModel.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/28/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var userData: UserData?

    init() {
        loadUserData()
    }

    private func loadUserData() {
        // Fetch user data from SessionManager
        let instance = SessionManager.shared
        self.userData = instance.userData
    }
}
