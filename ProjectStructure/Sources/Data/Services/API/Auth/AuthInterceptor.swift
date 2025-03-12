//
//  RequestInterceptor.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 12/12/24.
//

import Foundation
import Alamofire

final class AuthInterceptor: RequestInterceptor, @unchecked Sendable {
    
    let retryLimit = 3
    let retryDelay: TimeInterval = 2
    var isRetrying = false
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue(TokenManager.shared.accessToken, forHTTPHeaderField: "authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        if request.retryCount < self.retryLimit {
            if let statusCode = response?.statusCode, statusCode == 401, !isRetrying {
                self.isRetrying = true
                self.determineError(error: error, completion: completion)
            } else {
                completion(.retryWithDelay(self.retryDelay))
            }
        } else {
//            APIService.shared.session.cancelAllRequests()
            completion(.doNotRetry)
        }
    }
    
    private func determineError(error: Error, completion: @escaping (RetryResult) -> Void) {
        if let afError = error as? AFError {
            switch afError {
            case .responseValidationFailed(let reason):
                self.determineResponseValidationFailed(reason: reason, completion: completion)
            default:
                self.isRetrying = false
                completion(.retryWithDelay(self.retryDelay))
            }
        }
    }
    
    private func determineResponseValidationFailed(reason: AFError.ResponseValidationFailureReason, completion: @escaping (RetryResult) -> Void) {
        switch reason {
        case .unacceptableStatusCode(let code):
            switch code {
            case AuthenticationAction.refreshToken.rawValue:
                TokenManager.shared.refreshAccessToken { result in
                    switch result {
                    case .success:
                        self.isRetrying = false
                        completion(.retryWithDelay(self.retryDelay))
                    case .failure:
                        self.isRetrying = false
                        completion(.doNotRetry)
                    }
                }
                
            default: // AuthenticationAction.logout.rawValue
                self.isRetrying = false
//                APIService.shared.session.cancelAllRequests()
                // Redirect to the login page
                completion(.doNotRetry)
            }
        default:
            self.isRetrying = false
            completion(.retryWithDelay(self.retryDelay))
        }
    }
}
