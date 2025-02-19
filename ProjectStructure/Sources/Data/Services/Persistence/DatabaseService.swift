//
//  DatabaseService.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/2/25.
//

import Foundation

struct DatabaseService {
    
    let personService: PersonDBService
    
    init(repository: DatabaseRepositories) {
        self.personService = RealPersonService(dbRepository: repository.personRepository)
    }
}
