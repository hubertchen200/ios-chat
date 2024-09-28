//
//  LoginView.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/15/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel: LoginViewModel

    var body: some View {
        VStack {
            // Show a loading indicator when sign-in is in progress
            if loginViewModel.isLoading {
                ProgressView("Signing in...")
                    .padding()
            } else {
                Image(systemName: "lock.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                // Login form
                TextField("Email", text: $loginViewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding()
                
                SecureField("Password", text: $loginViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                
                
                Button("Login") {
                    
                    Task {
                        do {
                            try await loginViewModel.login()
                        } catch {
                            // Handle the error here
                            print("Login failed with error: \(error)")
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // Show error message if there’s an error
                if let error = loginViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
        }
        .padding(20)
    }
}

#Preview {
    ContentView()
}
