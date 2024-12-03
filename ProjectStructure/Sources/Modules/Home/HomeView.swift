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
    
    @StateObject private var coordinator: Coordinator
    @StateObject private var viewModel: ViewModel
    
    init() {
        let coordinator = Coordinator()
        _viewModel = StateObject(wrappedValue: ViewModel(coordinator: coordinator))
        _coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some View {
        VStack {
            Button {
                viewModel.triggerFullScreenAlert()
            } label: {
                Text("Show full screen")
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        
        .fullScreenCover(item: $coordinator.fullScreen) { item in
            switch item {
            case .test: SettingView()
            }
        }
    }
}

#Preview {
    HomeView()
}
