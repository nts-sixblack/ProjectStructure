//
//  RefreshTokenResponse.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 11/12/24.
//

import Foundation

struct ResfreshTokenRequest: Codable {
    let refreshToken: String
    var expiresInMins: Int = 1
}

struct ResfreshTokenResponse: Codable {

    let accessToken: String
    let refreshToken: String

}
