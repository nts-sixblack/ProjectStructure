//
//  Collection.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    var unique: [Element] {
        var result = [Element]()
        for element in self where !result.contains(element) {
            result.append(element)
        }
        return result
    }
}
