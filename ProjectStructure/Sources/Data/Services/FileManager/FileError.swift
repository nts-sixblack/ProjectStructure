//
//  FileError.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/3/25.
//

import Foundation

enum FileError: Error, LocalizedError {
//    case invalidSelf
    case securityScopeAccessFailed
    case notDirectory
//    case copyFailed(underlyingError: Error)
//    case attributeSettingFailed(underlyingError: Error)
    case fileModelCreationFailed(url: URL)
    case unowned(error: Error)
    
    var errorDescription: String? {
        switch self {
//        case .invalidSelf:
//            return "Reference to self is nil"
        case .securityScopeAccessFailed:
            return "Failed to access security scoped resource"
        case .notDirectory:
            return "Parent is not a directory"
//        case .copyFailed(let error):
//            return "Failed to copy file: \(error.localizedDescription)"
//        case .attributeSettingFailed(let error):
//            return "Failed to set file attributes: \(error.localizedDescription)"
        case let .fileModelCreationFailed(url):
            return "Failed to create File at URL: \(url.absoluteString)"
        case let .unowned(error):
            return "File error: \(error.localizedDescription)"
        }
    }
}
