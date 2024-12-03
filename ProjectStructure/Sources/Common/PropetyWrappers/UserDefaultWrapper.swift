//
//  UserDefaultWrapper.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T: Equatable> {
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaults = .standard

    var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                userDefaults.removeObject(forKey: key)
                return
            }
            userDefaults.set(newValue, forKey: key)
        }
    }
}
