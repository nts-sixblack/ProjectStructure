//
//  SettingView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.dismissLegacy) private var dismiss
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Setting View")

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                }

            }
        }
    }
}

#Preview {
    SettingView()
}
