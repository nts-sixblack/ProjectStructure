//
//  HomeView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @Service(\.localStorageService)
    private var localStorageService
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Button {
                viewModel.triggerErrorAlert()
            } label: {
                Text("Show full screen")
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
        
        .navigation(item: $viewModel.coordinator.navigation) { item in
            switch item {
            case .view1: SettingView()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeView.ViewModel())
}
