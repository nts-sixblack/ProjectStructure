//
//  Optional.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

protocol StringType {
    var isEmpty: Bool { get }
}

extension String : StringType { }

extension Optional where Wrapped: StringType {
    var isNullOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
extension Optional where Wrapped == Double {
    func toStringHoursAndMinutes(format: String = "%02d") -> String {
        return Double.convertHourAndMinute(time: self ?? 0)
    }
}
extension Optional where Wrapped == Int {
    var isNullOrZero: Bool {
        guard let self else { return true }
        return self == 0
    }
}


// MARK: - Optional String functions
extension Optional where Wrapped == String {
    func toNoAvailableIfEmpty() -> String? {
        return self.isNullOrEmpty ? "N/A" : self
    }
    
    var catchNilAndReturnEmpty: String {
        return self ?? ""
    }
}

// MARK: - Optional Boolean function
extension Optional where Wrapped == Bool {
    var unWrappedWithTrueDefault: Bool {
        return self ?? true
    }
    
    var unWrappedWithFalseDefault: Bool {
        return self ?? false
    }
}


// MARK: - Optional Int functions
extension Optional where Wrapped == Int {
    func toString() -> String? {
        if let value = self {
           return "\(value)"
        }
        return nil
    }
    
    var unwrapWithDefaultZero: Int {
        return self ?? 0
    }
}
