//
//  Service.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

protocol Service {

    var shouldAutostart: Bool { get }

    func start()
    func stop()
}
