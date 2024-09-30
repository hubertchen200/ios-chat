//
//  NotificationView.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/15/24.
//

import SwiftUI

struct NotificationView: View {
    // Bindings for user data (example initial values)
    @State private var firstName = "John"
    @State private var lastName = "Doe"
    @State private var email = "john.doe@example.com"
    @State private var username = "johndoe"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    // First Name
                    HStack {
                        Text("First Name")
                        Spacer()
                        TextField("Enter First Name", text: $firstName)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    // Last Name
                    HStack {
                        Text("Last Name")
                        Spacer()
                        TextField("Enter Last Name", text: $lastName)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    // Email
                    HStack {
                        Text("Email")
                        Spacer()
                        TextField("Enter Email", text: $email)
                            .keyboardType(.emailAddress)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    // Username
                    HStack {
                        Text("Username")
                        Spacer()
                        TextField("Enter Username", text: $username)
                            .multilineTextAlignment(.trailing)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                }
                
                // Save Button
                Button(action: {
                    // Handle save action here (e.g., send data to the server or save locally)
                    saveProfile()
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .navigationTitle("Profile")
        }
    }
    // Save Profile Function
    func saveProfile() {
        // Logic to save the profile (e.g., make API call or update session data)
        print("Profile saved: \(firstName), \(lastName), \(email), \(username)")
    }
}

#Preview {
    NotificationView()
}
