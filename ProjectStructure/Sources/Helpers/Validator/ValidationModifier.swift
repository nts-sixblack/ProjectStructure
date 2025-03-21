//
//  ValidationModifier.swift
//  SwiftUI-Validation
//
// Created by Shaban on 24/05/2021.
//  Copyright © 2020 Sha. All rights reserved.
//

import Foundation
import SwiftUI

/// A typealias for a view that displays validation error messages.
///
/// - Parameter message: The validation error message.
/// - Returns: A view that represents the validation error.
public typealias ValidationErrorView<ErrorView: View> = (_ message: String) -> ErrorView

/// A container that holds validation-related components and provides a method to trigger validation.
public struct ValidationContainer {
    
    /// The validator responsible for handling validation logic.
    public let validator: any Validatable
    
    /// A publisher that emits validation events.
    public let publisher: ValidationPublisher
    
    /// A subject that allows for manual triggering of validation events.
    public let subject: ValidationSubject

    /// Triggers validation using the associated validator.
    ///
    /// - Parameters:
    ///   - isDisabled: A flag indicating whether validation should be disabled. Defaults to `false`.
    ///   - shouldShowError: A flag indicating whether validation errors should be displayed. Defaults to `true`.
    public func validate(isDisabled: Bool = false, shouldShowError: Bool = true) {
        validator.triggerValidation(
            isDisabled: isDisabled,
            shouldShowError: shouldShowError
        )
    }
}

public extension View {

    /// A modifier used for validating a root publisher.
    /// Whenever the publisher changes, the value will be validated
    /// and propagated to this view.
    /// In case it's invalid, an error message will be displayed under the view
    ///
    /// - Parameter container: the validation container.
    /// - Parameter errorView: the view displaying the validation message.
    ///   - errorView: a custom error view
    /// - Returns: a view after applying the validation modifier
    func validation<ErrorView: View>(
            _ container: ValidationContainer?,
            errorView: ValidationErrorView<ErrorView>? = nil) -> some View {
        guard let container = container else {
            return eraseToAnyView()
        }
        let validationModifier = ValidationModifier(container: container, errorView: errorView)
        return modifier(validationModifier).eraseToAnyView()
    }

    /// A modifier used for validating a root publisher.
    /// Whenever the publisher changes, the value will be validated
    /// and propagated to this view.
    /// In case it's invalid, an error message will be displayed under the view
    ///
    /// - Parameter container: the validation container
    /// - Returns: a view after applying the validation modifier
    func validation(_ container: ValidationContainer?) -> some View {
        guard let container = container else {
            return eraseToAnyView()
        }
        let validationModifier = ValidationModifier<EmptyView>(container: container, errorView: nil)
        return modifier(validationModifier).eraseToAnyView()
    }

}

/// A modifier for applying the validation to a view.
public struct ValidationModifier<ErrorView: View>: ViewModifier {
    @State var latestValidation: Validation = .success

    public let container: ValidationContainer
    private let errorView: ValidationErrorView<ErrorView>?

    public init(
            container: ValidationContainer,
            errorView: ValidationErrorView<ErrorView>? = nil) {
        self.container = container
        self.errorView = errorView
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
            validationMessage
        }.onReceive(container.publisher.removeDuplicates()) { validation in
            self.latestValidation = validation
        }.onReceive(container.subject.removeDuplicates()) { validation in
            self.latestValidation = validation
        }
    }

    public var validationMessage: some View {
        switch latestValidation {
        case .success:
            return EmptyView().eraseToAnyView()
        case .failure(let message):
            guard let view = errorView?(message) else {
                let text = Text(message)
                        .foregroundColor(Color.red)
                        .font(.system(size: 14))
                return text.eraseToAnyView()
            }
            return view.eraseToAnyView()
        }
    }
}
