//
//  RootViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI
import Combine

extension RootView {
    class ViewModel: ObservableObject {
        
        @Published var path = FlowPath()
        @Published var coordinator = Coordinator()
        
        private let cancelBag = CancelBag()
        
        init(container: DIContainer) {
            container.appState.updates(for: \.path)
                .sink { [weak self] newPath in
                    guard let self = self else { return }
                    if self.path != newPath {
                        self.path = newPath
                    }
                }
                .store(in: cancelBag)
        }
    }
}
