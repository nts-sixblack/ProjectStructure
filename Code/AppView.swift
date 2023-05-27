//
//  ContentView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import SwiftUI

struct AppView: View {
    
    @StateObject var appManager = AppManager()
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        NavigationView {
            RootView(size: size, safeArea: safeArea)
                .environmentObject(appManager)
        }
        .navigationViewStyle(StackNavigationViewStyle())    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(size: .init(), safeArea: .init())
    }
}
