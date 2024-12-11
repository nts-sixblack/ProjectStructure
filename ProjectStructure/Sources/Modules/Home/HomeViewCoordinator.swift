//
//  HomeViewCoordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation

extension HomeView {
    struct Coordinator {
        
        enum Alert: Equatable {
            case error(title: String, message: String)
            case success(title: String, message: String)
        }
        
        enum Navigation: Identifiable {
            case view1
            
            var id: String {
                return "\(self)"
            }
        }
        
        var alert: Alert?
        var navigation: Navigation?
    }
}
