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
    @State private var showButtonPermission: Bool = false
    @State private var showButtonPhotoPermission: Bool = false
    
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
                
                Button {
                    viewModel.openDataView()
                } label: {
                    Text("Data View")
                }
                
                if showButtonPermission {
                    Button {
                        injected.userPermissions.request(permission: .pushNotifications)
                    } label: {
                        Text("Request push notification")
                    }
                }
                
                if showButtonPhotoPermission {
                    Button {
                        injected.userPermissions.request(permission: .photoLibrary(accessLevel: .readWrite))
                    } label: {
                        Text("Request photo permission")
                    }

                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .flowDestination(for: Coordinator.Navigation.self) { item in
                switch item {
                case .home: HomeView(viewModel: .init())
                case .settings: SettingView(viewModel: .init())
                case .data: DataView(viewModel: .init())
                }
            }
            .onReceive(pathUpdate) { path in
                DispatchQueue.main.async {
//                    viewModel.path = path
                }
            }
            .onReceive(pushNotificationUpdate) { self.showButtonPermission = $0 }
            .onReceive(allowImageUpdate) { self.showButtonPhotoPermission = $0 }
        }
    }
}

// MARK: - State update
private extension RootView {
    private var pathUpdate: AnyPublisher<FlowPath, Never> {
        injected.appState.updates(for: \.path)
    }
    
    private var pushNotificationUpdate: AnyPublisher<Bool, Never> {
        injected.appState.updates(for: \.permissions.pushNotification)
            .map { $0 == .notRequested || $0 == .denied }
            .eraseToAnyPublisher()
    }
    
    private var allowImageUpdate: AnyPublisher<Bool, Never> {
        injected.appState.updates(for: \.permissions.photoLibrary)
            .map { $0 == .notRequested || $0 == .denied }
            .eraseToAnyPublisher()
    }
    
    
}
