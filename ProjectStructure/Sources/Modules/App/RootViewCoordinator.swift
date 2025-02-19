//
//  AppCoordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

extension RootView {
    struct Coordinator: BaseCoordinator {
        
        enum Navigation: BaseNavigation {
            case home
            case settings
            case data
        }
        
        var alert: Alert?

    }
}
