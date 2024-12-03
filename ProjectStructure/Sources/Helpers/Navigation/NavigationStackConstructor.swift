//
//  NavigationStackConstructor.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

@ViewBuilder func NavigationStackConstructor<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    if #available(iOS 16, *) {
        NavigationStack(root: content)
    } else {
        NavigationView(content: content)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}
