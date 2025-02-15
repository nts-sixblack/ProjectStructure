//
//  DeepLinksHandler.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import Foundation

enum DeepLink: Equatable {
    
    case home
    case list
    case setting
    
    init?(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        
        switch components.host {
        case "home":
            self = .home
        case "list":
            self = .list
        case "setting":
            self = .setting
        default:
            return nil
        }
    }
}

// MARK: - DeepLinksHandler

protocol DeepLinksHandler {
    func open(deepLink: DeepLink)
}

struct RealDeepLinksHandler: DeepLinksHandler {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func open(deepLink: DeepLink) {
        switch deepLink {
        case .home:
            self.container.appState.bulkUpdate {
                var path = FlowPath()
                path.push(RootView.Coordinator.Navigation.home)
                path.push(HomeView.Coordinator.Navigation.view1)
                $0.path = path
            }
            break
        case .setting:
            self.container.appState.bulkUpdate {
                var path = FlowPath()
                path.push(RootView.Coordinator.Navigation.settings)
                $0.path = path
            }
            break
        default:
            break
        }
    }
}
