//
//  PersonDBRepository.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/2/25.
//

import Foundation
import Combine
import CoreData

protocol PersonRepository {
    func hasLoadedCountries() -> AnyPublisher<Bool, Error>
    
    func getAll() -> AnyPublisher<LazyList<Person>, Error>
    func store(persons: [Person]) -> AnyPublisher<Void, Error>
    func countries(search: String) -> AnyPublisher<LazyList<Person>, Error>
}

struct RealPersonRepository: PersonRepository {
    
    let persistentStore: PersistentStore
    
    func hasLoadedCountries() -> AnyPublisher<Bool, any Error> {
        let fetchRequest = PersonMO.getOnePerson()
        return persistentStore
            .count(fetchRequest)
            .map { $0 > 0 }
            .eraseToAnyPublisher()
    }
    
    func store(persons: [Person]) -> AnyPublisher<Void, any Error> {
        return persistentStore
            .update { context in
                persons.forEach {
                    $0.store(in: context)
                }
            }
    }
    
    func countries(search: String) -> AnyPublisher<LazyList<Person>, any Error> {
        let fetchRequest = PersonMO.getPerson(search: search)
        return persistentStore
            .fetch(fetchRequest) {
                Person(managedObject: $0)
            }
            .eraseToAnyPublisher()
    }
    
    func getAll() -> AnyPublisher<LazyList<Person>, Error> {
        let fetchRequest = PersonMO.fetchRequest()
        return persistentStore
//            .fetch(fetchRequest, map: {
//                Person(managedObject: $0)
//            })
            .fetch(fetchRequest) {
                Person(managedObject: $0)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Fetch Requests
extension PersonMO {
    static func getOnePerson() -> NSFetchRequest<PersonMO> {
        let request = newFetchRequest()
        request.fetchLimit = 1
        return request
    }
    
    static func getPerson(search: String) -> NSFetchRequest<PersonMO> {
        let request = newFetchRequest()
        if search.count == 0 {
            request.predicate = NSPredicate(value: true)
        } else {
            let nameMatch = NSPredicate(format: "name CONTAINS[cd] %@", search)
            request.predicate = NSCompoundPredicate(type: .or, subpredicates: [nameMatch])
        }
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.fetchBatchSize = 10
        return request
    }
}
