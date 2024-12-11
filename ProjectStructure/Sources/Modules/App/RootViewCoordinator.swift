//
//  AppCoordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

extension RootView {
    struct Coordinator: TestCoordinator {
        var id = UUID()
        
        enum Navigation: Identifiable {
            case home
            case setting
            
            var id: String {
                return "\(self)"
            }
        }
        
        var navigation: Navigation?
    }
}
