//
//  OAuthCredential.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 11/12/24.
//

import Foundation
import Alamofire

struct OAuthCredential: AuthenticationCredential {
    let accessToken: String
    let refreshToken: String
    let userID: String
    let expiration: Date

    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
}

class OAuthAuthenticator: Authenticator {
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }

    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        let refreshURL = AppConstant.url + "auth/refresh"
        let resfreshTokenRequest = ResfreshTokenRequest(refreshToken: credential.refreshToken)

        session.request(refreshURL, method: .post, parameters: resfreshTokenRequest, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let resfreshTokenResponse = try JSONDecoder().decode(ResfreshTokenResponse.self, from: data)
                        
                        let newCredential = OAuthCredential(accessToken: resfreshTokenResponse.accessToken,
                                                            refreshToken: resfreshTokenResponse.refreshToken,
                                                            userID: "1",
                                                            expiration: Date(timeIntervalSinceNow: 60 * 5)) // 5 minutes
                        
                        completion(.success(newCredential))
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
//        // If authentication server CANNOT invalidate credentials, return `false`
//        return false

        // If authentication server CAN invalidate credentials, then inspect the response matching against what the
        // authentication server returns as an authentication failure. This is generally a 401 along with a custom
        // header value.
         return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `true`
//        return true

        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
         let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
         return urlRequest.headers["Authorization"] == bearerToken
    }
}
