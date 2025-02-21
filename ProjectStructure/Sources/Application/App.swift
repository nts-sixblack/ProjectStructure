//
//  App.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 11/2/25.
//

import Foundation
import SwiftUI
import EnvironmentOverrides

@main
struct MainApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            appDelegate.rootView
        }
    }
}

extension AppEnvironment {
    var rootView: some View {
        RootView(viewModel: .init())
            .modifier(RootViewAppearance())
            .attachEnvironmentOverrides(onChange: onChangeHandler)
            .inject(container)
    }
    
    private var onChangeHandler: (EnvironmentValues.Diff) -> Void {
        return { diff in
            if !diff.isDisjoint(with: [.locale, .sizeCategory]) {
//                self.container.appState[\.path] = FlowPath()
            }
        }
    }
}
