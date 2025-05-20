//
//  LocalStorageService.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

protocol UserDefaultService: AnyObject {
    var isFirstTimeOpenApp: Bool { get set }
}

private struct Keys {
    static let isFirstTimeOpenApp = "isFirstTimeOpenApp"
}

class LocalStorageService: UserDefaultService {
    static let shared = LocalStorageService()

    @ObjectUserDefaultWrapper(key: Keys.isFirstTimeOpenApp, defaultValue: true)
    var isFirstTimeOpenApp: Bool
    
}
