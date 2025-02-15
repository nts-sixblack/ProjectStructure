//
//  AppEnvironment.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import Foundation
import UIKit

struct AppEnvironment {
    
    static var shared: AppEnvironment = .bootstrap()
    
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let userPermission = RealUserPermissionsInteractor(appState: appState, openAppSettings: {
            URL(string: UIApplication.openSettingsURLString).flatMap {
                UIApplication.shared.open($0, options: [:], completionHandler: nil)
            }
        })
        let diContainer = DIContainer(appState: appState, userPermissions: userPermission)
        let deepLinksHandler = RealDeepLinksHandler(container: diContainer)
        let pushNotificationsHandler = RealPushNotificationsHandler(deepLinksHandler: deepLinksHandler)
        
        let systemEventsHandler = RealSystemEventsHandler(
            container: diContainer,
            deepLinksHandler: deepLinksHandler,
            pushNotificationsHandler: pushNotificationsHandler
        )
        
        return AppEnvironment(container: diContainer, systemEventsHandler: systemEventsHandler)
    }
    
}
