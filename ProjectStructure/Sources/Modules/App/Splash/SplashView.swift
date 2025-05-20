//
//  SplashView.swift
//  MapTracking
//
//  Created by sau.nguyen on 17/4/25.
//

import SwiftUI

struct SplashView: View {
    
    @Injected var localStorage: LocalStorageService
    @Navigation var navigator
    
    var body: some View {
        VStack {
            Text("Splash View")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            pushToHome()
        }
    }
}

// MARK: Func
private extension SplashView {
    func pushToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            if localStorage.isFirstTimeOpenApp {
                navigator.push(RootView.Coordinator.Navigation.introduce)
            } else {
                navigator.push(RootView.Coordinator.Navigation.content)
            }
        })
    }
}

#Preview {
    SplashView()
        .preview()
}
