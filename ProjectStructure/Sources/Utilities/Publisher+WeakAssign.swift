//
//  Publisher+WeakAssign.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 6/12/24.
//

import Foundation
import Combine

extension Publisher where Failure == Never {
    func weakAssign<T: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<T, Output>,
        on object: T
    ) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
