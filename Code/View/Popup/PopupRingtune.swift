//
//  PopupRingtune.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 27/05/2023.
//

import SwiftUI

struct PopupRingtune: View {
    
    @EnvironmentObject var appManager: AppManager
    
    var body: some View {
        VStack {
            Text("aasddfasdfdf")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                .padding(.horizontal)
            
            ButtonFill(title: "asasdasddfa", icon: "questionmark.circle", iconColor: .white, backgroundColor: Color(hex: "282142"), cornerRadius: 30) {
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            ButtonFill(title: "afadsfasdf", icon: "square.and.arrow.down", iconColor: .white, backgroundColor: .blue, cornerRadius: 30) {
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            HStack {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .padding(.all)
                    .background(
                        Circle()
                            .fill(.black.opacity(0.35))
                    )
                
                Spacer()
                
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .padding(.all)
                    .background(
                        Circle()
                            .fill(.black.opacity(0.35))
                    )
                
                Spacer()
                
                Image(systemName: "trash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .padding(.all)
                    .background(
                        Circle()
                            .fill(.black.opacity(0.35))
                    )
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(
            Rectangle()
                .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
                .foregroundColor(.red)
                .ignoresSafeArea()
        )
    }
}

struct PopupRingtune_Previews: PreviewProvider {
    static var previews: some View {
        PopupRingtune()
    }
}
