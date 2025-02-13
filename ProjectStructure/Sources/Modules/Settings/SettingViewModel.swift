//
//  SettingViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension SettingView {
    class ViewModel: ObservableObject {
        
        @Published var coordinator = Coordinator()
        
        func triggerErrorAlert() {
            
        }
    }
}
