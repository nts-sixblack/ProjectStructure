//
//  FileViewCoordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/3/25.
//

import Foundation

extension FileView {
    struct Coordinator: BaseCoordinator {
        
        enum Alert: BaseAlert {
            case error(title: String, message: String)
            case success(title: String, message: String)
        }
        
        enum Navigation: BaseNavigation {
            case subView
        }

        var alert: Alert?
    }
}
