//
//  RootViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension RootView {
    class ViewModel: ObservableObject {
        
        @Service(\.localStorageService)
        private var localStorageService: LocalStorageService
        
        @Published var coordinator = Coordinator()
        
        func openHomeView() {
            coordinator.navigation = .home
        }
        
        func openSettingView() {
            coordinator.navigation = .setting
        }
    }
}
