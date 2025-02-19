//
//  ServiceContainer.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

class ServiceContainer {
    static var shared = ServiceContainer()
    
    // Services that is used least one time in app
    lazy var localStorageService: LocalStorageService = UserDefaultService()
    lazy var databaseService: DatabaseService = DatabaseService(repository: DatabaseRepositories())
    lazy var apiService: APIService = APIService()
}
