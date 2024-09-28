//
//  UserService.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/23/24.
//

import Foundation
import UIKit

class UserService {
    
    static func getToken(user_id: String, username: String) async throws -> TokenResponse {
        guard let url = URL(string: "https://user.hubertchen200.site/token") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let bodyData = ["user_id": user_id, "username": username]
        guard let body = try? JSONSerialization.data(withJSONObject: bodyData, options: []) else {
            throw NSError(domain: "InvalidBodyData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to encode request body"])
        }
        
        print(body)
        request.httpBody = body
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            
            throw URLError(.badServerResponse)
        }
        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
        return tokenResponse
    }
    
    static func signIn(email: String, password: String) async throws -> SignInResponse {
        guard let url = URL(string: "https://user.hubertchen200.site/signin") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let bodyData = ["email": email, "password": password]
        guard let body = try? JSONSerialization.data(withJSONObject: bodyData, options: []) else {
            throw NSError(domain: "InvalidBodyData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to encode request body"])
        }
        
        print(body)
        request.httpBody = body
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            
            throw URLError(.badServerResponse)
        }
        let signInResponse = try JSONDecoder().decode(SignInResponse.self, from: data)
        return signInResponse
    }
          
    
    
    
    static func signUp(email: String, firstName: String, lastName: String, userName: String, password: String) async throws -> SignUpResponse {
        guard let url = URL(string: "https://user.hubertchen200.site/user") else {
            throw URLError(.badURL)
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyData = [
                "email": email,
                "firstname": firstName,
                "lastname": lastName,
                "username": userName,
                "password": password
            ]
            
            // Convert the body data to JSON
            guard let body = try? JSONSerialization.data(withJSONObject: bodyData, options: []) else {
                throw NSError(domain: "InvalidBodyData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to encode request body"])
            }
            request.httpBody = body
            
            // Execute the request asynchronously
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check if the response status is 201 (Created)
        guard let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode == 201 || httpResponse.statusCode == 400 else {
                throw URLError(.badServerResponse)
            }
            
            // Decode the response JSON into SignUpResponse
            let signupResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
            return signupResponse
    }

    static func signinAndGetToken(email: String, password: String) async throws -> SignInResponse {
        var signInResponse = try await UserService.signIn(email: email, password: password)


        guard let data = signInResponse.data, signInResponse.status == "success" else {
            throw NSError(domain: "SignInFailed", code: 0, userInfo: [NSLocalizedDescriptionKey: signInResponse.error ?? "Sign-in failed"])

        }
        
        let tokenResponse = try await UserService.getToken(user_id:  email, username: data.username)
        signInResponse.token = tokenResponse.token
        
        return signInResponse

    }
    
    static func getCurrentTimestamp() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"  // Format: Year-Month-Day Hour:Minute:Second
        return dateFormatter.string(from: date)
    }
    
}
