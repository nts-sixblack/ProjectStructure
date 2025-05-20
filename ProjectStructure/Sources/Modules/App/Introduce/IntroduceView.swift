//
//  IntroduceView.swift
//  MapTracking
//
//  Created by sau.nguyen on 17/4/25.
//

import SwiftUI

struct IntroduceView: View {
    
    enum StepIntroduce: CaseIterable, Nextable {
        case step1, step2, step3
        
        var title: String {
            switch self {
            case .step1:
                return "Step 1"
            case .step2:
                return "Step 2"
            case .step3:
                return "Step 3"
            }
        }
        
        var description: String {
            switch self {
            case .step1:
                return "Step 1 description"
            case .step2:
                return "Step 2 description"
            case .step3:
                return "Step 3 description"
            }
        }
    }
    
    @Injected var localStorage: LocalStorageService
    @Navigation var navigator
    
    @State var step: StepIntroduce = .step1
    
    var body: some View {
        VStack {
            TabView(selection: $step) {
                ForEach(StepIntroduce.allCases, id: \.self) { step in
                    VStack {
                        Text(step.title)
                        Text(step.description)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(step)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Button(step == .step3 ? "Done" : "Next") {
                withAnimation {
                    step.next {
                        localStorage.isFirstTimeOpenApp = false
                        navigator.push(RootView.Coordinator.Navigation.content)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 30)
//            .buttonStyle(ActionButtonStyle())
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    IntroduceView()
}
