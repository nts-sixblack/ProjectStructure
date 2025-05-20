//
//  FileViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/3/25.
//

import Foundation
import Combine
import SwiftUI

extension FileView {
    class ViewModel: BaseViewModel {
        @Injected var fileStorageManager: FileStorageManager
        @Navigation var navigation
        
        @Published var coordinator: Coordinator = Coordinator()
        @Published var isLoading: Bool = false
        @Published var rootFile: FileItem
        @Published var selectedFile: FileItem?
        
        private let cancelBag = CancelBag()
        
        init(rootFile: FileItem) {
            self.rootFile = rootFile
        }
        
        func onSelectedItem(item: FileItem) {
            selectedFile = item
            DispatchQueue.main.async { [unowned self] in
                navigation.push(Coordinator.Navigation.subView)
            }
        }
        
        func addNewFolder() {
            fileStorageManager.createFolder(name: "NewFolder", in: rootFile)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        self.coordinator.alert = .error(title: "Error", message: error.localizedDescription)
                    }
                }, receiveValue: { [unowned self] newFolder in
                    rootFile.children.append(newFolder)
                    rootFile.children.sort(by: >)
                })
                .store(in: cancelBag)
        }
        
        func addNewFile() {
            let string = "abcxyz"
            let data: Data = string.data(using: .utf8)!
            
            fileStorageManager.createFile(name: "FileName", from: data, type: .plainText, in: rootFile)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        self.coordinator.alert = .error(title: "Error", message: error.localizedDescription)
                    }
                }, receiveValue: { [unowned self] newFolder in
                    rootFile.children.append(newFolder)
                    rootFile.children.sort(by: >)
                })
                .store(in: cancelBag)
        }
    }
}
