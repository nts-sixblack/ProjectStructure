//
//  NavigationDestinationModifier.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

extension View {
    public func navigationDestinationLegacy<Item: Identifiable, Destination: View>(
        item: Binding<Item?>,
        @ViewBuilder destination: @escaping (Item) -> Destination
    ) -> some View {
        self.background(
            NavigationLink(
                destination: item.wrappedValue.map { destination($0) },
                isActive: Binding(
                    get: { item.wrappedValue != nil },
                    set: { isActive in
                        if !isActive {
                            item.wrappedValue = nil
                        }
                    }
                )
            ) {
                EmptyView()
            }
        )
    }
}
