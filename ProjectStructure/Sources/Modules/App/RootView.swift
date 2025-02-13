//
//  RootView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation
import SwiftUI
import Combine

struct RootView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        FlowStack($viewModel.path, withNavigation: true) {
            VStack {
                Text("Hello, World!")
                Text("Root View")
                
                Button {
                    viewModel.openHomeView()
                } label: {
                    Text("Home View")
                }
                
                Button {
                    viewModel.openSettingView()
                } label: {
                    Text("Setting View")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .flowDestination(for: Coordinator.Navigation.self) { item in
                switch item {
                case .home: HomeView()
                case .settings: SettingView()
                }
            }
            .onReceive(pathUpdate) { path in
                DispatchQueue.main.async {
                    viewModel.path = path
                }
            }
        }
    }
}

// MARK: - State update
private extension RootView {
    private var pathUpdate: AnyPublisher<FlowPath, Never> {
        injected.appState.updates(for: \.path)
    }
}
