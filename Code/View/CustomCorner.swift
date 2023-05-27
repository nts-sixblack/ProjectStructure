//
//  CustomCorner.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import SwiftUI

struct CustomCorner: Shape {
    var corners : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}
