//
//  Coordinator.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation

protocol BaseAlert: Identifiable, Equatable {
    
}

protocol BaseFullScreen: Identifiable, Equatable {
    
}

protocol BaseNavigation: Identifiable, Equatable {
    
}

protocol BaseCoordinator {
    associatedtype Alert: BaseAlert
    associatedtype FullScreen: BaseFullScreen
    associatedtype Navigation: BaseNavigation
    
    var alert: Alert? { get set }
    var fullScreen: FullScreen? { get set }
    var navigation: Navigation? { get set }
}

struct AnyBaseAlert: BaseAlert {
    private let _isEqual: (Any) -> Bool
    private let _id: AnyHashable
    
    var id: AnyHashable { _id }
    
    init<T: BaseAlert>(_ alert: T?) {
        _id = alert?.id
        _isEqual = { other in
            guard let otherAlert = other as? T else { return false }
            return alert == otherAlert
        }
    }
    
    static func == (lhs: AnyBaseAlert, rhs: AnyBaseAlert) -> Bool {
        lhs._isEqual(rhs)
    }
}

struct AnyBaseFullScreen: BaseFullScreen {
    private let _isEqual: (Any) -> Bool
    private let _id: AnyHashable
    
    var id: AnyHashable { _id }
    
    init<T: BaseFullScreen>(_ fullScreen: T?) {
        _id = fullScreen?.id
        _isEqual = { other in
            guard let otherFullScreen = other as? T else { return false }
            return fullScreen == otherFullScreen
        }
    }
    
    static func == (lhs: AnyBaseFullScreen, rhs: AnyBaseFullScreen) -> Bool {
        lhs._isEqual(rhs)
    }
}

struct AnyBaseNavigation: BaseNavigation {
    private let _isEqual: (Any) -> Bool
    private let _id: AnyHashable
    
    var id: AnyHashable { _id }
    
    init<T: BaseNavigation>(_ navigation: T?) {
        _id = navigation?.id
        _isEqual = { other in
            guard let otherNavigation = other as? T else { return false }
            return navigation == otherNavigation
        }
    }
    
    static func == (lhs: AnyBaseNavigation, rhs: AnyBaseNavigation) -> Bool {
        lhs._isEqual(rhs)
    }
}

class AnyCoordinator: ObservableObject {
    private let _alert: () -> AnyBaseAlert?
    private let _fullScreen: () -> AnyBaseFullScreen?
    private let _navigation: () -> AnyBaseNavigation?
    private let _rawName: String
    
    var alert: AnyBaseAlert? { _alert() }
    var fullScreen: AnyBaseFullScreen? { _fullScreen() }
    var navigation: AnyBaseNavigation? { _navigation() }
    var rawName: String { _rawName }
    var baseCoordinator: Any?
    
    init<Coordinator: BaseCoordinator>(_ coordinator: Coordinator) {
        _alert = { AnyBaseAlert(coordinator.alert) }
        _fullScreen = { AnyBaseFullScreen(coordinator.fullScreen) }
        _navigation = { AnyBaseNavigation(coordinator.navigation) }
        _rawName = String(describing: type(of: coordinator))
        baseCoordinator = coordinator
    }
    
}

protocol TestCoordinator: Equatable, Identifiable {
    
}
