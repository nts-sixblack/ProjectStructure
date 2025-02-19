//
//  PersonDBService.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/2/25.
//

import Foundation
import CoreData
import Combine

protocol PersonDBService {
    func refreshCountriesList() -> AnyPublisher<Void, Error>
    func load(persons: LoadableSubject<LazyList<Person>>, search: String)
}

struct RealPersonService: PersonDBService {
    let dbRepository: PersonRepository
    
    init(dbRepository: PersonRepository) {
        self.dbRepository = dbRepository
    }
    
    func load(persons: LoadableSubject<LazyList<Person>>, search: String) {
        let cancelBag = CancelBag()
        persons.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        Just<Void>
            .withErrorType(Error.self)
            .flatMap { [dbRepository] in
                dbRepository.getAll()
            }
            .sinkToLoadable({ data in
                persons.wrappedValue = data
            })
            .store(in: cancelBag)
    }
    
    func refreshCountriesList() -> AnyPublisher<Void, Error> {
        
        let range = Array(1...10)
        
        return Publishers.Sequence(sequence: range)
            .map { index in
                return Person(code: "\(index)", name: "randome name")
            }
            .flatMap { [dbRepository] item in
                dbRepository.store(persons: [item])
            }
            .eraseToAnyPublisher()
    }
}
