//
//  BaseView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 11/2/25.
//

import SwiftUI

struct BaseView<Content: View, ViewModel: BaseViewModel>: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    let content: Content
    let onBackAction: (() -> Void)? = nil
    
    init(viewModel: ViewModel, @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
            if viewModel.isLoading {
                ZStack {
                    Color.white.opacity(0.3)
                    
                    ProgressView()
                        .padding()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
            }
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.white)
        .disabled(viewModel.isLoading)
    }
}
