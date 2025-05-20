//
//  DataViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/2/25.
//

import Foundation
import SwiftUI
import CoreData

extension DataView {
    class ViewModel: BaseViewModel {
        
        @Injected var databaseService: DatabaseService
        
        @Published var coordinator = Coordinator()
        @Published var isLoading: Bool = false
        @Published var persons: Loadable<LazyList<Person>>
        
        var cancelBag = CancelBag()
        
        init(persons: Loadable<LazyList<Person>> = .notRequested) {
            _persons = .init(initialValue: persons)
        }
        
        func getPerson() {
//            databaseService.personRepository
//                .load(persons: loadableSubject(\.persons), search: "abc")
        }
    }
}
