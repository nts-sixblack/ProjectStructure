//
//  APIService.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 11/12/24.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func login(_ login: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void)
    func getUserData(completion: @escaping (Result<UserDataResponse, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    private var session: Session
    private var authenticator: OAuthAuthenticator
    private var credential: OAuthCredential
    
    init() {
        self.credential = OAuthCredential(accessToken: "a0",
                                          refreshToken: "r0",
                                          userID: "u0",
                                          expiration: Date(timeIntervalSinceNow: 60 * 5))
        self.authenticator = OAuthAuthenticator()
        self.session = Session(configuration: .default, interceptor: AuthenticationInterceptor(authenticator: authenticator, credential: credential))
    }
    
    func login(_ login: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let loginURL = AppConstant.url + "auth/login"
        
        session.request(loginURL, method: .post, parameters: login, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        let accessToken = loginResponse.accessToken
                        let refreshToken = loginResponse.refreshToken
                        let userId = "\(loginResponse.id)"
                        let expirationDate = Date(timeIntervalSinceNow: 60 * 1) // Token in 1 minutes
                        
                        let newCredential = OAuthCredential(accessToken: accessToken,
                                                            refreshToken: refreshToken,
                                                            userID: userId,
                                                            expiration: expirationDate)
                        self.credential = newCredential
                        self.session = Session(interceptor: AuthenticationInterceptor(authenticator: self.authenticator, credential: self.credential))
                        completion(.success(loginResponse))
                        
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
    
    func getUserData(completion: @escaping (Result<UserDataResponse, any Error>) -> Void) {
        let getUserDataURL = AppConstant.url + "auth/me"
        
        session.request(getUserDataURL, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let userDataResponse = try JSONDecoder().decode(UserDataResponse.self, from: data)
                        
                        completion(.success(userDataResponse))
                        
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
