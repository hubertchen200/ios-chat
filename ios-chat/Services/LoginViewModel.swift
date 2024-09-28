//
//  LoginViewModel.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/28/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    func login() async throws {
        // Indicate that loading has started
        DispatchQueue.main.async {
            self.isLoading = true
        }

        do {
            // Perform the async sign-in request
            let signInResponse = try await UserService.signinAndGetToken(email: email, password: password)

            // Switch to the main thread to update any @Published properties
            DispatchQueue.main.async {
                self.isLoading = false
                if signInResponse.status == "success" {
                    let sessionInstance = SessionManager.shared
                    sessionInstance.saveSession(userData: signInResponse.data, token: signInResponse.token)
                    
                    self.isLoggedIn = true
                    self.errorMessage = nil
                } else {
                    self.isLoggedIn = false
                    self.errorMessage = "Sign-in failed"
                }
            }
        } catch {
            // Switch to the main thread to handle errors and update UI
            DispatchQueue.main.async {
                self.isLoading = false
                self.isLoggedIn = false
                self.errorMessage = "An error occurred during login: \(error.localizedDescription)"
            }
        }
    }
}
