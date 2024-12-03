//
//  SettingViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension SettingView {
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
        
        func triggerFullScreenAlert() {
            coordinator.wrappedValue.fullScreen = .test
        }
        
        func triggerSuccessAlert() {
            coordinator.wrappedValue.alert = .success
        }
        
        func triggerErrorAlert() {
            coordinator.wrappedValue.alert = .error
        }
    }
}
