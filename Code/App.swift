//
//  ProjectStructureApp.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import SwiftUI

@main
struct ProjectStructureApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                let size = geometry.size
                let safeArea = geometry.safeAreaInsets
                
                AppView(size: size, safeArea: safeArea)
            }
        }
    }
}
