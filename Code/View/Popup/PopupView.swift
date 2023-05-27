//
//  PopupView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import SwiftUI

struct PopupView: View {
    
    @EnvironmentObject var appManager: AppManager
    
    @State var offset: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            
            if appManager.popup != .null {
                VStack{}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            offset = UIScreen.main.bounds.height
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                appManager.popup = .null
                            })
                            
                        }
                    }
            }
            
            VStack {
                switch appManager.popup {
                case .null:
                   EmptyView()
                case .ringTune:
                    PopupRingtune()
                }
            }
            .frame(maxWidth: .infinity)
            .offset(y: offset)
        }
        .animation(.easeInOut(duration: 0.3), value: offset)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(.black.opacity(appManager.popup == .null ? 0 : 0.3))
        .onChange(of: appManager.popup) { newValue in
            if newValue != .null {
                offset = 0
            }
        }
        
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            NavigationView {
                RootView(size: geometry.size, safeArea: geometry.safeAreaInsets)
                    .environmentObject(AppManager())
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
