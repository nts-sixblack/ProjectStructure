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
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = DIContainer(appState: AppState())
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
    init(appState: AppState) {
        self.init(appState: Store(appState))
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
