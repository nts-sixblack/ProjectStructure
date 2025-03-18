//
//  HomeViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension HomeView {
    
    class ViewModel: BaseViewModel {
        
        @Service(\.apiService)
        private var apiService: APIService
        
        @Service(\.fileStorageManager)
        var fileStorageManager
        
        @Navigation var navigator
        
        @Published var coordinator: Coordinator = Coordinator()
        @Published var isLoading: Bool = false
        
        @Published var showButtonNotificationPermission: Bool = false
        @Published var showButtonPhotoPermission: Bool = false
        
        private let cancelBag = CancelBag()
        
        init(container: DIContainer) {
            container.appState.updates(for: \.permissions.pushNotification)
                .sink { [weak self] status in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.showButtonNotificationPermission = status == .notRequested || status == .denied
                    }
                }
                .store(in: cancelBag)
            
            container.appState.updates(for: \.permissions.photoLibrary)
                .sink { [weak self] status in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.showButtonPhotoPermission = status == .notRequested || status == .denied
                    }
                    print("photoLibrary")
                }
                .store(in: cancelBag)
        }
        
        func login() {
            let loginRequest = LoginRequest(username: "emilys", password: "emilyspass")
            apiService.login(loginRequest) { result in
                switch result {
                case let .success(loginResponse):
                    print(loginResponse)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func getUserData() {
            apiService.getUserData { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
        func navigateToView1() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                navigator.push(Coordinator.Navigation.view1)
            }
        }
        
        func showView1() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                navigator.push(Coordinator.Navigation.view1)
            }
        }
        
        func showView2() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                navigator.push(Coordinator.Navigation.view2)
            }
        }
        
        func showFileView() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                navigator.push(Coordinator.Navigation.file)
            }
        }
        
        func fullScreen() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                navigator.presentSheet(Coordinator.FullScreen.viewController, withNavigation: true)
            }
        }
    }
}
