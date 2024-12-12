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
    
    let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        
        // Config time out
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        
        let interceptor = AuthInterceptor()
        
        // Cache
        // Just using cache or config time out
//        let responseCacher = ResponseCacher(behavior: .modify { _, response in
//          let userInfo = ["date": Date()]
//          return CachedURLResponse(
//            response: response.response,
//            data: response.data,
//            userInfo: userInfo,
//            storagePolicy: .allowed)
//        })
        
        let networkLogger = GitNetworkLogger()
        return Session(
            configuration: configuration,
            interceptor: interceptor,
//            cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger]
        )
    }()
    
    init() {
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
                        
                        TokenManager.shared.accessToken = loginResponse.accessToken
                        TokenManager.shared.refreshToken = loginResponse.refreshToken
                        
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
