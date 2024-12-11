//
//  SettingViewCoordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension SettingView {
    struct Coordinator {
        enum Navigation {
            case view1
            
            var id: String {
                return "\(self)"
            }
        }
        
        var navigation: Navigation?
    }
}
