//
//  HomeView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    @EnvironmentObject var navigator: FlowPathNavigator
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Button {
                fullScreen()
            } label: {
                Text("Show full screen")
            }
            
            Button {
                showView1()
            } label: {
                Text("View 1")
            }

            Button {
                showView2()
            } label: {
                Text("View 2")
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
                print(navigator)
                print(injected.appState.value.path)
            } label: {
                Text("Show path")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        
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
            $0
                .position(.center)
                .animation(.easeIn)
                .appearFrom(.centerScale)
                .backgroundColor(.black.opacity(0.3))
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .disappearTo(.centerScale)
                .isOpaque(true)
                .dragToDismiss(false)
        }
        .flowDestination(for: Coordinator.Navigation.self) { item in
            switch item {
            case .view1: Text("View 1")
            case .view2: Text("View 2")
            }
        }
        .flowDestination(for: Coordinator.FullScreen.self) { item in
            switch item {
            case .viewController: HomeView(viewModel: .init())
            }
        }
    }
}

// Func
private extension HomeView {
    func showView1() {
        navigator.push(Coordinator.Navigation.view1)
    }
    
    func showView2() {
        navigator.push(Coordinator.Navigation.view2)
    }
    
    func fullScreen() {
        navigator.presentSheet(Coordinator.FullScreen.viewController, withNavigation: true)
    }
}

#Preview {
    HomeView(viewModel: .init())
}
