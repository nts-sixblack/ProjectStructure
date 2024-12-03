//
//  Service.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

@propertyWrapper
struct Service<Component> {
    var component: Component
    
    init(_ keyPath: KeyPath<ServiceContainer, Component>) {
        self.component = ServiceContainer.shared[keyPath: keyPath]
    }
    
    public var wrappedValue: Component {
        get { component }
        mutating set { component = newValue }
    }
}
