//
//  SigninModel.swift
//  ios-chat
//
//  Created by Hubert Chen on 9/28/24.
//

import Foundation

struct SignUpResponse: Codable {
    let status: String?
    let error: String?
}
struct SignInResponse: Codable {
    let data: UserData?
    let status: String?
    let error: String?
    var token: String?
}

struct TokenResponse: Codable {
    let token: String
}

struct UserData: Codable {
    let email: String
    let firstname: String
    let lastname: String
    let username: String
}




