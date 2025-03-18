//
//  SettingViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension SettingView {
    class ViewModel: BaseViewModel {
        
        @Published var coordinator = Coordinator()
        @Published var isLoading: Bool = false
        
        func triggerErrorAlert() {
            
        }
    }
}
