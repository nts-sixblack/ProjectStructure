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
        
        @Published var path = FlowPath()
        @Published var coordinator = Coordinator()
        
        func openHomeView() {
            path.push(Coordinator.Navigation.home)
        }
        
        func openSettingView() {
            path.push(Coordinator.Navigation.settings)
        }
        
        func openDataView() {
            path.push(Coordinator.Navigation.data)
        }
    }
}
