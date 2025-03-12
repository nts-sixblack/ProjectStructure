//
//  AppConstant.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

struct AppConstant {
    static let appName = getConfigurationValue(by: .appName).unsafelyUnwrapped
    static let appEnv = getConfigurationValue(by: .appEnv).unsafelyUnwrapped
    static let url = getConfigurationValue(by: .appUrl).unsafelyUnwrapped
}

private extension AppConstant {
    enum ConfigurationValue: String {
        case appName = "APP_NAME"
        case appEnv = "APP_ENV"
        case appUrl = "APP_URL"
    }
    
    static func getConfigurationValue(by key: ConfigurationValue) -> String? {
        return (Bundle.main.infoDictionary?[key.rawValue] as? String)?
                    .replacingOccurrences(of: "\\", with: "")
    }
}
