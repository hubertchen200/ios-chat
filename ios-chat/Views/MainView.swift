//
//  MainView.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/15/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            NavigationView {
                NotificationView()
            }
            .tabItem {
                Image(systemName: "bell.fill")
                Text("Notifications")
            }
            
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
    }
}


#Preview {
    MainView()
}
