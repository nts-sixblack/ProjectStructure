//
//  LocalStorageService.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

protocol LocalStorageService: AnyObject {
    var isFirstTimeOpenApp: Bool { get set }
}

private struct Keys {
    static let isFirstTimeOpenApp = "isFirstTimeOpenApp"
}

class UserDefaultService: LocalStorageService {
    static let shared = UserDefaultService()

    @ObjectUserDefaultWrapper(key: Keys.isFirstTimeOpenApp, defaultValue: true)
    var isFirstTimeOpenApp: Bool
    
   
}
