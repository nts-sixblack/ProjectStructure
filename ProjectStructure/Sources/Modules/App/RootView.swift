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
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStackConstructor {
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
            .navigation(item: $viewModel.coordinator.navigation) { item in
                switch item {
                case .home: HomeView()
                case .setting: SettingView()
                }
            }
        }
    }
}
