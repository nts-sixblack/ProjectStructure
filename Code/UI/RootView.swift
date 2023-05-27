//
//  RootView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appManager: AppManager
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    @State var sheet = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TabView(selection: $appManager.tab) {
                    Text("Chat")
                        .tag(Tab.chat)

                    Text("Sappay")
                        .tag(Tab.sapPay)

                    Text("Wallet")
                        .tag(Tab.wallet)

                    Text("DeFi")
                        .tag(Tab.deFi)

                    Text("Notification")
                        .tag(Tab.notification)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                VStack {
                    tabBar()
                }
                .frame(width: size.width, height: 70)
                .padding(.bottom, safeArea.bottom)
            }
            .frame(width: .infinity, height: .infinity, alignment: .bottom)
            
//            MARK: Popup
            PopupView()
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hex: "1E2346"))
        .navigationTitle("Checkkkk")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(backgroundColor: .black, opacity: 0.3, titleColor: .white)
        .toolbar {
            toolbarLeading
            toolbarTrailing
        }
    }
    
    @ViewBuilder
    func tabBar() -> some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabBarItem(tab: tab, currentTab: $appManager.tab, width: CGFloat((size.width-50)/CGFloat(Tab.allCases.count)))
                    .onTapGesture {
                        print("tappppp")
                    }
            }
            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
        }
        .frame(width: size.width, height: 70)
        .cornerRadius(1)
        
    }
    
    var toolbarLeading: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                appManager.popup = .ringTune
            } label: {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
            }

        }
    }
    
    var toolbarTrailing: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                appManager.popup = .ringTune
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
            }

        }
    }
}



struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            
            AppView(size: size, safeArea: safeArea)
        }
        
    }
}
