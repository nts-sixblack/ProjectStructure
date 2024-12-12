//
//  DataRequest+Extension.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 12/12/24.
//

import Foundation
import Alamofire


extension DataRequest {
    func customValidate(url: String) -> Self {
        return self.validate { request, response, data -> Request.ValidationResult in
            let statusCode = response.statusCode
            if statusCode != 401 {
                return .success(())
            } else {
                return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: AuthenticationAction.refreshToken.rawValue)))
            }
        }
    }
}

enum AuthenticationAction: Int {
    case refreshToken = 4010
    case logout = 4011
}
