//
//  LoginModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 11/12/24.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
    var expiresInMins: Int = 5
}

struct LoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
}
