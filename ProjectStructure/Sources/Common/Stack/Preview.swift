//
//  Preview.swift
//  ProjectStructure
//
//  Created by sau.nguyen on 20/5/25.
//

import Foundation
import SwiftUI

extension View {
    public func preview() -> some View {
        modifier(PreviewModifier())
    }
}

struct PreviewModifier: ViewModifier {

    @State var path = FlowPath()
    
    func body(content: Content) -> some View {
        FlowStack($path, withNavigation: true) {
            content
                .modifier(NavigatorModifier())
                .onFirstAppear {
                    let dependencies = Dependencies {
                        Dependency { LocalStorageService() }
                        Dependency { APIService() }
                        Dependency { FileStorageManager() }
                        Dependency { DatabaseService() }
                    }
                    dependencies.build()
                }
        }
    }
}
