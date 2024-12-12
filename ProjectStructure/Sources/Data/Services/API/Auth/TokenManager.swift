//
//  TokenManager.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 12/12/24.
//

import Foundation
import Alamofire
import KeychainAccess

class TokenManager {
    static var shared: TokenManager = .init()
    
    private var keychain: Keychain
    
    var accessToken: String {
        get { keychain[String.accessToken] ?? "" }
        set { keychain[String.accessToken] = newValue }
    }
    
    var refreshToken: String {
        get { keychain[String.refreshToken] ?? "" }
        set { keychain[String.refreshToken] = newValue }
    }
    
    private init() {
        keychain = Keychain().synchronizable(false)
    }
    
    func refreshAccessToken(completion: @escaping (Result<Bool, any Error>) -> Void) {
        let refreshTokenURL = AppConstant.url + "auth/refresh"
        AF.request(refreshTokenURL, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let resfreshTokenResponse = try JSONDecoder().decode(ResfreshTokenResponse.self, from: data)
                        
                        self.accessToken = resfreshTokenResponse.accessToken
                        self.refreshToken = resfreshTokenResponse.refreshToken
                        
                        completion(.success(true))
                        
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}

private extension String {
    static let accessToken = "KeyEncryption"
    static let refreshToken = "KeyEncryption"
}
