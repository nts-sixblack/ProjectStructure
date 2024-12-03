//
//  RootViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension RootView {
    class ViewModel: BaseViewModel {
        
        @Published private var internalCoordinator: Coordinator
        
        var coordinator: Binding<Coordinator> {
            Binding(
                get: { self.internalCoordinator },
                set: { self.internalCoordinator = $0 }
            )
        }
        
        init(coordinator: Coordinator) {
            self.internalCoordinator = coordinator
        }
        
        func openHomeView() {
            coordinator.wrappedValue.navigation = .home
        }
        
        func openSettingView() {
            coordinator.wrappedValue.navigation = .setting
        }
    }
}
