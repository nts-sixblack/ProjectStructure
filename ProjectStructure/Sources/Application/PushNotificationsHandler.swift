//
//  PushNotificationsHandler.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 19/11/24.
//

import Foundation
import UserNotifications

protocol PushNotificationsHandler { }

final class RealPushNotificationsHandler: NSObject, PushNotificationsHandler {
    
    private let deepLinksHandler: DeepLinksHandler
    
    init(deepLinksHandler: DeepLinksHandler) {
        self.deepLinksHandler = deepLinksHandler
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension RealPushNotificationsHandler: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        handleNotification(userInfo: userInfo, completionHandler: completionHandler)
    }
    
    func handleNotification(userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
//        guard let payload = userInfo["aps"] as? NotificationPayload,
//            let countryCode = payload["country"] as? Country.Code else {
//            completionHandler()
//            return
//        }
//        deepLinksHandler.open(deepLink: .showCountryFlag(alpha3Code: countryCode))
//        completionHandler()
    }
}
