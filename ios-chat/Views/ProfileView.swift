//
//  ProfileView.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/15/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel() // Initialize the ViewModel

      var body: some View {
          VStack(alignment: .leading, spacing: 10) {
              Text("Profile View")
                  .font(.largeTitle)
                  .bold()
              
              if let userData = viewModel.userData {
                  Text("Firstname: \(userData.firstname)")
                  Text("Lastname: \(userData.lastname)")
                  Text("Email: \(userData.email)")
                  Text("Username: \(userData.username)")
              } else {
                  Text("No user data available.")
              }
          }
          .padding()
      }
}

#Preview {
    ProfileView()
}
