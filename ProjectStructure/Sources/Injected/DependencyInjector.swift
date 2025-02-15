//
//  DependencyInjector.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import Foundation
import SwiftUI
import Combine

struct DIContainer: EnvironmentKey {
    
    let appState: Store<AppState>
    let userPermissions: UserPermissionsInteractor
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = DIContainer(appState: AppState())
    
    init(appState: Store<AppState>, userPermissions: UserPermissionsInteractor) {
        self.appState = appState
        self.userPermissions = userPermissions
    }
    
    init(appState: AppState) {
        let storeAppState = Store(appState)
        let userPermissionsInteractor = RealUserPermissionsInteractor(appState: storeAppState, openAppSettings: {
            URL(string: UIApplication.openSettingsURLString).flatMap {
                UIApplication.shared.open($0, options: [:], completionHandler: nil)
            }
        })
        self.init(appState: Store(appState), userPermissions: userPermissionsInteractor)
    }
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

// MARK: - Injection in the view hierarchy
extension View {
    
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
