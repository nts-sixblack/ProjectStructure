//
//  UserPermission.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 13/2/25.
//

import Foundation
import UserNotifications
import Photos

enum Permission {
    case pushNotifications
    case photoLibrary(accessLevel: PHAccessLevel)
}

extension Permission {
    enum Status: Equatable {
        case unknown
        case notRequested
        case granted
        case denied
    }
}

protocol UserPermissionsInteractor: AnyObject {
    func resolveStatus(for permission: Permission) // Check status of permission
    func request(permission: Permission) // Request permission
}

final class RealUserPermissionsInteractor: UserPermissionsInteractor {

    private let appState: Store<AppState>
    private let openAppSettings: () -> Void
    private let notificationCenter: SystemNotificationsCenter
    private let photoLibraryCenter: SystemPhotoLibraryCenter
    
    private var status: Bool = false

    init(appState: Store<AppState>,
         notificationCenter: SystemNotificationsCenter = UNUserNotificationCenter.current(),
         photoLibraryCenter: SystemPhotoLibraryCenter = PHPhotoLibrary.shared(),
         openAppSettings: @escaping () -> Void
    ) {
        self.appState = appState
        self.notificationCenter = notificationCenter
        self.photoLibraryCenter = photoLibraryCenter
        self.openAppSettings = openAppSettings
    }

    func resolveStatus(for permission: Permission) {
        let keyPath = AppState.permissionKeyPath(for: permission)
        let appState = appState
        switch permission {
        case .pushNotifications:
            Task { @MainActor in
                appState[keyPath] = await pushNotificationsPermissionStatus()
                print("Notification: \(appState.value.permissions.pushNotification)")
            }
        case let .photoLibrary(accessLevel):
            Task { @MainActor in
                appState[keyPath] = await photosPermissionStatus(for: accessLevel)
                print("Photo: \(appState.value.permissions.photoLibrary)")
            }
        }
    }

    func request(permission: Permission) {
        let keyPath = AppState.permissionKeyPath(for: permission)
        let currentStatus = appState[keyPath]
        guard currentStatus != .denied else {
            openAppSettings()
            return
        }
        switch permission {
        case .pushNotifications:
            Task {
                await requestPushNotificationsPermission()
            }
        case let .photoLibrary(accessLevel):
            Task {
                await requestPhotoLibraryPermission(for: accessLevel)
            }
        }
    }
}

// MARK: - Notification
private extension RealUserPermissionsInteractor {

    func pushNotificationsPermissionStatus() async -> Permission.Status {
        return await notificationCenter
            .currentSettings()
            .authorizationStatus.map
    }

    func requestPushNotificationsPermission() async {
        let center = notificationCenter
        let isGranted = (try? await center.requestAuthorization(options: [.alert, .sound])) ?? false
        appState[\.permissions.pushNotification] = isGranted ? .granted : .denied
    }
}

// MARK: - Photos
private extension RealUserPermissionsInteractor {
    func photosPermissionStatus(for accessLevel: PHAccessLevel) async -> Permission.Status {
        let status = PHPhotoLibrary.authorizationStatus(for: accessLevel)
        return status.map
    }

    func requestPhotoLibraryPermission(for accessLevel: PHAccessLevel) async {
        let center = photoLibraryCenter
//        let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
//        appState[\.permissions.photoLibrary] = (status == .authorized || status == .limited) ? .granted : .denied
        let status = (try? await center.requestAuthorization(for: accessLevel)) ?? .denied
        appState[\.permissions.photoLibrary] = status
    }
}
