//
//  AppCoordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

extension RootView {
    class Coordinator: BaseCoordinator, ObservableObject {
        
        enum Alert: BaseAlert {
            var id: String {
                return "\(self)"
            }
        }
        
        enum FullScreen: BaseFullScreen {
            var id: String {
                return "\(self)"
            }
        }
        
        enum Navigation: BaseNavigation {
            case home
            case setting
            
            var id: String {
                return "\(self)"
            }
        }
        
        @Published var alert: Alert?
        @Published var fullScreen: FullScreen?
        @Published var navigation: Navigation?
    }
}
