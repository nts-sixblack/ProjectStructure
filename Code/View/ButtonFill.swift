//
//  ButtonFill.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import SwiftUI

struct ButtonFill: View {
    let title: String
    var icon: String = ""
    var iconColor: Color = .black
    var backgroundColor: Color = .black
    var textColor: Color = .white
    var font: Font = .system(size: 20)
    var cornerRadius: CGFloat = 5
    var paddingVertical: CGFloat = 18
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                if !icon.isEmpty {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .font(font)
                }
                Text(title)
                    .font(font)
                    .foregroundColor(textColor)
                    
                Spacer()
            }
        }
        .padding(.vertical, paddingVertical)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
    }
}

struct ButtonFill_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFill(title: "abc") {
            
        }
    }
}
