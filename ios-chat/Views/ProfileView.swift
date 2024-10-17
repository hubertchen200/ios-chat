//
//  ProfileView.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/15/24.
//

import SwiftUI



struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel() // Initialize the ViewModel

      var body: some View {
          VStack(alignment: .leading, spacing: 10) {
              Text("Profile View")
                  .font(.largeTitle)
                  .bold()
              
              if let userData = viewModel.userData {
                  Form {
                      Section(header: Text("Personal Information")) {
                          // First Name
                          HStack {
                              Text("First Name")
                              Spacer()
                              TextField("Enter First Name", text: Binding(
                                                       get: { userData.firstname },
                                                       set: { viewModel.userData?.firstname = $0 }
                                                   ))
                                  .multilineTextAlignment(.trailing)
                                  .autocapitalization(.none)
                                  .disableAutocorrection(true)
                          }
                          
                          // Last Name
                          HStack {
                              Text("Last Name")
                              Spacer()
                              TextField("Enter Last Name", text: Binding(
                                get: { userData.lastname },
                                set: { viewModel.userData?.lastname = $0 }
                            ))
                                  .multilineTextAlignment(.trailing)
                                  .autocapitalization(.none)
                                  .disableAutocorrection(true)
                          }
                          
                          // Email
                          HStack {
                              Text("Email")
                              Spacer()
                              TextField("Enter Email", text: Binding(
                                get: {userData.email},
                                set: {viewModel.userData?.email = $0}
                              ))
                                  .keyboardType(.emailAddress)
                                  .multilineTextAlignment(.trailing)
                                  .autocapitalization(.none)
                                  .disableAutocorrection(true)
                          }
                          
                          // Username
                          HStack {
                              Text("Username")
                              Spacer()
                              TextField("Enter Username", text: Binding(
                                get: {userData.username},
                                set: {viewModel.userData?.username = $0}
                              ))
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
              } else {
                  Text("No user data available.")
              }
          }
          .padding()
      }
    
    
    func saveProfile() {
        // Logic to save the profile (e.g., make API call or update session data)
        print("Profile saved.")
    }
}

#Preview {
    ProfileView()
}
