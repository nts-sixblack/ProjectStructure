//
//  AppState.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import Foundation
import SwiftUI
import Combine

struct AppState: Equatable {
//    var userData = UserData()
    var path = FlowPath()
    var system = System()
    var permissions = Permissions()
    var test : Bool = false
}

extension AppState {
    struct UserData: Equatable {
        /*
         The list of countries (Loadable<[Country]>) used to be stored here.
         It was removed for performing countries' search by name inside a database,
         which made the resulting variable used locally by just one screen (CountriesList)
         Otherwise, the list of countries could have remained here, available for the entire app.
         */
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
    }
}

extension AppState {
    struct Permissions: Equatable {
        var pushNotification: Permission.Status = .unknown
        var photoLibrary: Permission.Status = .unknown
    }
    
    static func permissionKeyPath(for permission: Permission) -> WritableKeyPath<AppState, Permission.Status> {
        let pathToPermissions = \AppState.permissions
        switch permission {
        case .pushNotifications:
            return pathToPermissions.appending(path: \.pushNotification)
        case .photoLibrary(_):
            return pathToPermissions.appending(path: \.photoLibrary)
        }
    }
}

//func == (lhs: AppState, rhs: AppState) -> Bool {
//    return lhs.userData == rhs.userData &&
//        lhs.routing == rhs.routing &&
//        lhs.system == rhs.system &&
//        lhs.permissions == rhs.permissions
//}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
#endif
