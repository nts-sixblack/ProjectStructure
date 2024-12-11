//
//  HomeViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension HomeView {
    
    class ViewModel: ObservableObject {
        
        @Service(\.apiService)
        private var apiService: APIService
        
        @Published var coordinator: Coordinator = Coordinator()
        
        func login() {
            let loginRequest = LoginRequest(username: "emilys", password: "emilyspass")
            apiService.login(loginRequest) { result in
                switch result {
                case let .success(loginResponse):
                    print(loginResponse)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func getUserData() {
            apiService.getUserData { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
        func triggerErrorAlert() {
            coordinator.navigation = .view1
        }
    }
    
}
