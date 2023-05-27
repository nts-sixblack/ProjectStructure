//
//  Tab.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import Foundation

enum Tab: String, CaseIterable {
    case chat = "Chat"
    case sapPay = "Sappay"
    case wallet = "Wallet"
    case deFi = "DeFi"
    case notification = "Notification"
    
    var image: String {
        switch self {
        case .chat:
            return "ic_chat"
        case .sapPay:
            return "ic_sappay"
        case .wallet:
            return "ic_wallet"
        case .deFi:
            return "ic_defi"
        case .notification:
            return "ic_notification"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
