//
//  HomeView.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/15/24.
//

import SwiftUI

struct HomeView: View {
    // Example data for friends and friend requests
    @State private var friends = ["Alice", "Bob", "Charlie"]
    @State private var friendRequests = ["David", "Emma"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Friend Requests and Friends in a single List
                List {
                    // Friend Requests Section
                    if !friendRequests.isEmpty {
                        Section(header: Text("Friend Requests").font(.headline)) {
                            ForEach(friendRequests, id: \.self) { request in
                                HStack {
                                    Text(request)
                                        .font(.title2)
                                    
                                    Spacer()
                                    
                                    // Accept Button
                                    Button(action: {
                                        acceptRequest(request: request)
                                    }) {
                                        Text("Accept")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.green)
                                            .cornerRadius(8)
                                    }
                                    
                                    // Decline Button
                                    Button(action: {
                                        declineRequest(request: request)
                                    }) {
                                        Text("Decline")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.red)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                    }
                    
                    // Friends List Section
                    Section(header: Text("Friends").font(.headline)) {
                        ForEach(friends, id: \.self) { friend in
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                
                                Text(friend)
                                    .font(.title2)
                                    .padding(.leading, 8)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Add Friend Button
                Button(action: {
                    // Handle Add Friend action
                }) {
                    Text("Add Friend")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("")
        }
    }
    
    // Accept Friend Request Function
    func acceptRequest(request: String) {
        // Logic to accept the friend request
        friendRequests.removeAll { $0 == request }
        friends.append(request)
    }
    
    // Decline Friend Request Function
    func declineRequest(request: String) {
        // Logic to decline the friend request
        friendRequests.removeAll { $0 == request }
    }
}
#Preview {
    HomeView()
}
