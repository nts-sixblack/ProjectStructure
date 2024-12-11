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
        
        @Published var coordinator: Coordinator = Coordinator()
        
        func triggerErrorAlert() {
            coordinator.navigation = .view1
        }
    }
    
}
