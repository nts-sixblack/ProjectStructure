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
            SplashView()
                .modifier(NavigatorModifier())
                .flowDestination(for: Coordinator.Navigation.self) { item in
                    switch item {
                    case .introduce: IntroduceView()
                    case .content: ContentView()
                    }
                }
        }
    }
}

enum Tab: CaseIterable {
    case home, data, file, setting
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .data:
            return "network"
        case .file:
            return "folder"
        case .setting:
            return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .data:
            return "Data"
        case .file:
            return "File"
        case .setting:
            return "Settings"
        }
    }
}

struct ContentView: View {
    
    @Injected var fileStorageManager: FileStorageManager
    
    @Environment(\.injected) private var injected: DIContainer
    @StateObject private var keyboardResponder = KeyboardResponder()
    @State var currentTab: Tab = .home
    
    var body: some View {
        ZStack {
            TabView(selection: $currentTab) {
                HomeView(viewModel: .init(container: injected))
                    .tag(Tab.home)

                DataView(viewModel: .init())
                    .tag(Tab.data)
                
                FileView(viewModel: .init(rootFile: fileStorageManager.rootFolder))
                    .tag(Tab.file)
                
                SettingView(viewModel: .init())
                    .tag(Tab.setting)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.bottom, keyboardResponder.keyboardHeight > 0 ? 0 : 60)
//            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            tabBar()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    func tabBar() -> some View {
        VStack {
            ZStack {
                Color.white
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: -5)
                
                HStack (spacing: 0) {
                    ForEach(Tab.allCases, id: \.self) { item in
                        Button(action: {
                            withAnimation {
                                currentTab = item
                            }
                        }, label: {
                            Image(systemName: currentTab == item ? "\(item.icon).fill" : item.icon)
//                                .toIcon(24)
                                .foregroundStyle(currentTab == item ? Color.primary : Color.gray)
                                .padding()
                        })
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
