//
//  FileError.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/3/25.
//

import Foundation

enum FileError: Error, LocalizedError {
    case securityScopeAccessFailed
    case notDirectory
    case itemNotFound
    case fileModelCreationFailed(url: URL)
    case unowned(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .itemNotFound:
            return "Item not found"
        case .securityScopeAccessFailed:
            return "Failed to access security scoped resource"
        case .notDirectory:
            return "Parent is not a directory"
        case let .fileModelCreationFailed(url):
            return "Failed to create File at URL: \(url.absoluteString)"
        case let .unowned(error):
            return "File error: \(error.localizedDescription)"
        }
    }
}
