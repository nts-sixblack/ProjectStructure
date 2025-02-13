//
//  ViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 20/11/24.
//

import Foundation
import SwiftUI

protocol BaseViewModel: ObservableObject {
    associatedtype CoordinatorType: BaseCoordinator
    
    var coordinator: CoordinatorType { get }
}
