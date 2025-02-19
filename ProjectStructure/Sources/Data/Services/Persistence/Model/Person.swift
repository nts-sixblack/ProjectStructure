//
//  Country.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/2/25.
//

import Foundation
import CoreData

struct Person: Codable, Equatable {
    var code: String
    var name: String
}

extension Person: Identifiable {
    var id: String { code }
}

// MARK: Core data
extension PersonMO: ManagedEntity { }

extension Person {
    @discardableResult
    func store(in context: NSManagedObjectContext) -> PersonMO? {
        guard let person = PersonMO.insertNew(in: context) else { return nil }
        person.name = name
        person.code = code
        return person
    }
    
    init?(managedObject: PersonMO) {
        guard let name = managedObject.name,
              let code = managedObject.code
            else { return nil }
        
        self.init(code: code, name: name)
    }
}
