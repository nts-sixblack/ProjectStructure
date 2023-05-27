//
//  AppManager.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import Foundation

class AppManager: ObservableObject {
    
    @Published var popup: Popup
    @Published var tab: Tab
    
    init() {
        self.popup = .null
        self.tab = .chat
    }
    
    
}
