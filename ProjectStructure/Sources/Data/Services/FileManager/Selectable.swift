//
//  Selectable.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 16/3/25.
//

import Foundation

protocol Selectable {
    var selected: Bool { get set }
}

extension Collection where Element: Selectable {
    
    func countSelected() -> Int {
        self.filter { $0.selected }.count
    }
    
    var selected: [Self.Element] { filter { $0.selected } }
    var nonselected: [Self.Element] { filter { !$0.selected } }
    
    var isAllSelected: Bool {
        self.allSatisfy { $0.selected }
    }
    
}

extension RangeReplaceableCollection where Element: Selectable {
    
    mutating func removeSelected() {
        self = filter { !$0.selected }
    }
    
}

/// For dictionary
extension Collection {
    func countSelected<Key, E: Selectable>() -> Int where Element == (key: Key, value: [E]) {
        self.flatMap { $0.value }.filter { $0.selected }.count
    }
}

extension Dictionary {
    
    mutating func removeSelected<Element: Selectable>() where Value == [Element] {
        self = self.compactMapValues { $0.filter { !$0.selected }.isEmpty ? nil : $0.filter { !$0.selected } }
    }
    
    func isAllSelected<Element: Selectable>() -> Bool where Value == [Element] {
        values.allSatisfy { $0.isAllSelected }
    }
    
    func selected<Element: Selectable>() -> some BidirectionalCollection<Element> where Value == [Element] {
        return map({ $0.value.selected }).joined()
    }
    
}
