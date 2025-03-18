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
                Text(AppConstant.appName)
                Text(AppConstant.appEnv)
                Text(AppConstant.url)
                
                Button {
                    viewModel.openHomeView()
                } label: {
                    Text(LocalizedStringKey(stringLiteral: "Home View"))
                }
                
                Button {
                    viewModel.openHomeView()
                } label: {
                    Text("Home View".localized)
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .modifier(NavigatorModifier())
            .flowDestination(for: Coordinator.Navigation.self) { item in
                switch item {
                case .home: HomeView(viewModel: .init(container: injected))
                case .settings: SettingView(viewModel: .init())
                case .data: DataView(viewModel: .init())
                }
            }
        }
    }
}
