//
//  AppEnvironment.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import Foundation

struct AppEnvironment {
    
    static var shared: AppEnvironment = .bootstrap()
    
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    
    private static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        
        let diContainer = DIContainer(appState: appState)
        
        let deepLinksHandler = RealDeepLinksHandler(container: diContainer)
        let pushNotificationsHandler = RealPushNotificationsHandler(deepLinksHandler: deepLinksHandler)
        
        let systemEventsHandler = RealSystemEventsHandler(
            container: diContainer,
            deepLinksHandler: deepLinksHandler,
            pushNotificationsHandler: pushNotificationsHandler
        )
        
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
    
}
