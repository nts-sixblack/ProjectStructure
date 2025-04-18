//
// Created by Shaban on 31/05/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import Foundation

/// This strategy allows you to choose between displaying all validation messages at once
/// or displaying them one by one.
public enum CompositeValidationMessagesStrategy {
    /// Displays all validation messages at once.
    case all
    
    /// Displays validation messages one by one, typically stopping at the first failure.
    case onByOne
}

public class CompositeValidator: StringValidator {
    private let validators: [any StringValidator]
    private let type: ValidationType
    public let strategy: CompositeValidationMessagesStrategy

    public var publisher: ValidationPublisher!
    public var subject: ValidationSubject = .init()
    public var onChanged: [OnValidationChange] = []

    public init(validators: [any StringValidator],
                type: ValidationType,
                strategy: CompositeValidationMessagesStrategy) {
        self.validators = validators
        self.type = type
        self.strategy = strategy
    }

    public let message: StringProducerClosure = {
        ""
    }
    public var value: String? = ""

    public func validate() -> Validation {
        for item in validators {
            var val = item
            val.value = value
        }

        var errors = validators.compactMap {
            let validation = $0.validate()
            $0.valueChanged(validation)
            return validation.error
        }
        switch type {
        case .all:
            break
        case .any(let messageTitle):
            for validator in validators {
                let validation = validator.validate()
                validator.valueChanged(validation)
                if validation.isSuccess {
                    return .success
                }
            }
            if let messageTitle {
                errors = [messageTitle] + errors
            }
        }

        guard !errors.isEmpty else {
            return .success
        }

        switch strategy {
        case .all:
            return .failure(message: ErrorFormatter.format(errors: errors))
        case .onByOne:
            guard let error = errors.first else {
                return .success
            }
            return .failure(message: ErrorFormatter.format(errors: [error]))
        }
    }

}

extension CompositeValidator {

    /// Represents the type of validation logic used in `CompositeValidator`.
    public enum ValidationType {
        /// Requires all validation rules to pass.
        case all
        
        /// Requires at least one validation rule to pass.
        ///
        /// - Parameters:
        ///   - messageTitle: An optional title for the validation message when at least one rule passes.
        case any(messageTitle: String?)
    }

}
