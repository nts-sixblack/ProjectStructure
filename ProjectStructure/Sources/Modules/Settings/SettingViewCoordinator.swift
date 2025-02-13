//
//  SettingViewCoordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension SettingView {
    struct Coordinator: BaseCoordinator {
        
        enum Alert: BaseAlert {
            case error(title: String, message: String)
            case success(title: String, message: String)
        }
        
        enum FullScreen: BaseFullScreen {
            case viewController
        }
        
        enum Navigation: BaseNavigation {
            case view1
            case view2
        }

        var alert: Alert?

    }
}
