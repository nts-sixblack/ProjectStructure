//
//  AppDelegate.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

typealias NotificationPayload = [AnyHashable: Any]
typealias FetchCompletion = (UIBackgroundFetchResult) -> Void

@MainActor
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private lazy var environment = AppEnvironment.bootstrap()
    private var systemEventsHandler: SystemEventsHandler { environment.systemEventsHandler }
    
    var rootView: some View {
        environment.rootView
    }
    
    let dependencies = Dependencies {
        Dependency { LocalStorageService() }
        Dependency { APIService() }
        Dependency { FileStorageManager() }
        Dependency { DatabaseService() }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        dependencies.build()
        dependencies
            .compactMap { $0 as? Service }
            .filter { $0.shouldAutostart }
            .forEach { $0.start() }
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        SceneDelegate.register(systemEventsHandler)
        return sceneConfig
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        systemEventsHandler.handlePushRegistration(result: .success(deviceToken))
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        systemEventsHandler.handlePushRegistration(result: .failure(error))
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async -> UIBackgroundFetchResult {
        return await systemEventsHandler.appDidReceiveRemoteNotification(payload: userInfo)
    }
}
