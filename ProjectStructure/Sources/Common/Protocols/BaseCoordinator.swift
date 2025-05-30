//
//  Coordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation

protocol BaseAlert: Equatable {
}

protocol BaseFullScreen: Hashable, Codable {
}

protocol BaseNavigation: Codable {
}

struct DefaultAlert: BaseAlert { }

struct DefaultFullScreen: BaseFullScreen { }

struct DefaultNavigation: BaseNavigation { }

protocol BaseCoordinator {
    associatedtype Alert: BaseAlert = DefaultAlert
    associatedtype FullScreen: BaseFullScreen = DefaultFullScreen
    associatedtype Navigation: BaseNavigation = DefaultNavigation
}

struct DefaultCoordinator: BaseCoordinator { }
