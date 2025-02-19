//
//  DBRepository.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/2/25.
//

import Foundation

struct DatabaseRepositories {
    
    let personRepository: PersonRepository
    
    init(version: UInt = CoreDataStack.Version.actual) {
        let persistentStore: CoreDataStack = CoreDataStack(version: version)
        self.personRepository = RealPersonRepository(persistentStore: persistentStore)
    }
}
