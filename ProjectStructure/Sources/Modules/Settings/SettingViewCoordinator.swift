//
//  SettingViewCoordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension SettingView {
    class Coordinator: BaseCoordinator, ObservableObject {
        
        enum Alert: BaseAlert {
            case success
            case error
            
            var id: String {
                return "\(self)"
            }
        }
        
        enum FullScreen: BaseFullScreen {
            case test
            
            var id: String {
                return "\(self)"
            }
        }
        
        enum Navigation: BaseNavigation {
            case view1
            case view2
            case view3
            
            var id: String {
                return "\(self)"
            }
        }
        
        @Published var alert: Alert?
        @Published var fullScreen: FullScreen?
        @Published var navigation: Navigation?
    }
}
