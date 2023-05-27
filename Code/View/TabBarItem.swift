//
//  TabBarItem.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import SwiftUI

struct TabBarItem: View {
    
    var tab: Tab
    @Binding var currentTab: Tab
    var width: CGFloat
    
    var body: some View {
        VStack {
            Image("\(tab.image)")
                .resizable()
                .foregroundColor(currentTab == tab ? .accentColor : .black)
                .scaledToFit()
                .frame(width: width * 0.4)
            
            Text("\(tab.rawValue)")
                .font(.system(size: 18))
                .foregroundColor(currentTab == tab ? .accentColor : .black)
        }
        .frame(width: width)
        .animation(.easeOut(duration: 0.4), value: currentTab)
        .onTapGesture {
            currentTab = tab
        }
    }
}
