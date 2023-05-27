//
//  AppDelegate.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import Foundation
import UIKit
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
////        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().tintColor = UIColor(named: "light_gray")
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//        UINavigationBar.appearance().backgroundColor = UIColor(named: "primary_purple")
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
