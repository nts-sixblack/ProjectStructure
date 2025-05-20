//
//  HomeView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            VStack {
                Button {
                    viewModel.fullScreen()
                } label: {
                    Text("Show full screen")
                }
                
                Button {
                    viewModel.navigateToView1()
                } label: {
                    Text("View 1")
                }

                Button {
                    viewModel.showView2()
                } label: {
                    Text("View 2")
                }
                
                Button {
                    viewModel.showFileView()
                } label: {
                    Text("File View")
                }
                
                Button {
                    viewModel.coordinator.alert = .error(title: "Title", message: "Description")
                } label: {
                    Text("Popup error")
                }

                Button {
                    viewModel.coordinator.alert = .success(title: "Title", message: "Description")
                } label: {
                    Text("Popup success")
                }

                Button("Login") {
                    viewModel.login()
                }
                
                Button("Get user data") {
                    viewModel.getUserData()
                }
                
                Button {
                    print(viewModel.navigator)
                    print(injected.appState.value.path)
                } label: {
                    Text("Show path")
                }
                
                if viewModel.showButtonNotificationPermission {
                    Button {
                        injected.userPermissions.request(permission: .pushNotifications)
                    } label: {
                        Text("Request push notification")
                    }
                }
                
                if viewModel.showButtonPhotoPermission {
                    Button {
                        injected.userPermissions.request(permission: .photoLibrary(accessLevel: .readWrite))
                    } label: {
                        Text("Request photo permission")
                    }

                }
                
            }
            .popup(item: $viewModel.coordinator.alert) { item in
                switch item {
                case let .error(title, message):
                    CustomAlertView(
                        title: title,
                        titleColor: .red,
                        description: message,
                        primaryActionTitle: "OK",
                        primaryAction: {
                            viewModel.coordinator.alert = nil
                        })
                    
                case let .success(title, message):
                    CustomAlertView(
                        title: title,
                        description: message,
                        cancelActionTitle: "Cancel",
                        cancelAction: {
                            print("cancel")
                            viewModel.coordinator.alert = nil
                        },
                        primaryActionTitle: "OK",
                        primaryAction: {
                            viewModel.coordinator.alert = nil
                        }
                    )
                }
            } customize: {
                $0.centerPopup()
            }
        }
        .flowDestination(for: Coordinator.Navigation.self) { item in
            switch item {
            case .view1: Text("View 1")
            case .view2: Text("View 2")
//            case .file: FileView(viewModel: .init(rootFile: viewModel.fileStorageManager.rootFolder))
            case .file: Text("File View")
            }
        }
        .flowDestination(for: Coordinator.FullScreen.self) { item in
            switch item {
            case .viewController: HomeView(viewModel: .init(container: injected))
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init(container: DIContainer.defaultValue))
}
