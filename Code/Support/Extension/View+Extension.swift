//
//  View+Extension.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import Foundation
import SwiftUI

extension View {
    func dissMissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
    
    func navigationBarColor(backgroundColor: UIColor?, opacity: CGFloat = 1, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, opacity: opacity, titleColor: titleColor))
    }
}
