//
//  CustomAlertView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 11/12/24.
//

import Foundation
import SwiftUI

struct CustomAlertView<Content: View>: View {
    
    var icon: Image? = nil
    let title: String?
    var titleColor: Color = .black
    let description: String?
    
    var background: Color = .white
    var showLine: Bool = true
    var buttonAxis: Axis = .horizontal
    
    var cancelActionTitle: String?
    var cancelActionTitleColor: Color = .gray
    var cancelAction: (() -> Void)?
    
    var isPrimaryActionReady: ()->Bool = { true }
    var primaryActionTitle: String?
    var primaryActionTitleColor: Color = .black
    var primaryAction: (() -> Void)?
    var dismissAction: (() -> Void)?
    
    @ViewBuilder var customContent: () -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            if let icon {
                icon
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.top)
            }
            
            if let title {
                Text(title)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .font(.system(size: 16))
                    .foregroundStyle(titleColor)
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if let description {
                Text(description)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            customContent()
                .padding(.horizontal)
                .padding(.bottom, 12)
            
            if buttonAxis == .horizontal {
                if showLine {
                    CustomDivider()
                        .frame(height: 1)
                }
                
                HStack {
                    if let cancelAction, let cancelActionTitle {
                        Button {
                            cancelAction()
                            dismissAction?()
                        } label: {
                            Text(cancelActionTitle)
                                .foregroundStyle(cancelActionTitleColor)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                        }
                    }
                    
                    if cancelAction != nil && cancelActionTitle != "" && primaryActionTitle != "" && showLine {
                        CustomDivider()
                            .frame(width: 1)
                    }
                    
                    if let primaryAction, let primaryActionTitle {
                        Button {
                            if isPrimaryActionReady() {
                                primaryAction()
                                dismissAction?()
                            }
                        } label: {
                            Text(primaryActionTitle)
                                .font(.system(size: 16))
                                .foregroundColor(isPrimaryActionReady() ? primaryActionTitleColor :  Color.gray)
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                        }
                    }
                }
                .frame(height: 38)
                .frame(maxWidth: .infinity)
            } else {
                if let primaryAction, let primaryActionTitle {
                    if showLine {
                        CustomDivider()
                            .frame(height: 1)
                    }
                    
                    Button {
                        if isPrimaryActionReady() {
                            primaryAction()
                            dismissAction?()
                        }
                    } label: {
                        Text("**\(primaryActionTitle)**")
                            .font(.title3)
                            .foregroundColor(isPrimaryActionReady() ? primaryActionTitleColor :  Color.gray)
                            .frame(height: 36)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                }
                
                if let cancelAction, let cancelActionTitle {
                    CustomDivider()
                        .frame(height: 1)
                    
                    Button {
                        cancelAction()
                        dismissAction?()
                    } label: {
                        Text(cancelActionTitle)
                            .foregroundStyle(Color.gray)
                            .font(.system(size: 16))
                            .frame(height: 36)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .background(background)
        .cornerRadius(8)
        .padding(.horizontal, 30)
    }
    
    func CustomDivider() -> some View {
        Divider().overlay(Color.gray)
    }
    
}


extension CustomAlertView where Content == EmptyView {
    
    init(
        icon: Image? = nil,
        title: String?,
        titleColor: Color = .black,
        description: String?,
        
        background: Color = .white,
        showLine: Bool = true,
        buttonAxis: Axis = .horizontal,
        
        cancelActionTitle: String? = "Cancel",
        cancelActionTitleColor: Color = .gray,
        cancelAction: (() -> Void)? = nil,
        
        isPrimaryActionReady: @escaping () -> Bool = { true },
        primaryActionTitle: String? = "OK",
        primaryActionTitleColor: Color = .black,
        primaryAction: (() -> Void)? = nil,
        dismissAction: (() -> Void)? = nil
        ) {
            self.icon = icon
            self.title = title
            self.titleColor = titleColor
            self.description = description
            
            self.background = background
            self.showLine = showLine
            self.buttonAxis = buttonAxis
            
            self.cancelAction = cancelAction
            self.cancelActionTitleColor = cancelActionTitleColor
            self.cancelActionTitle = cancelActionTitle
            
            self.isPrimaryActionReady = isPrimaryActionReady
            self.primaryActionTitle = primaryActionTitle
            self.primaryActionTitleColor = primaryActionTitleColor
            self.primaryAction = primaryAction
            
            self.customContent = { EmptyView() }
        }
    
}
