//
//  DatabaseService.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/2/25.
//

import Foundation

struct DatabaseService {
    
    let personRepository: PersonRepository
    
    init(version: UInt = CoreDataStack.Version.actual) {
        let persistentStore: CoreDataStack = CoreDataStack(version: version)
        personRepository = PersonRepository(persistentStore: persistentStore)
    }
}
