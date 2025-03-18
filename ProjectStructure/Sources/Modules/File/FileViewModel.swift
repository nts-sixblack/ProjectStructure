//
//  FileViewModel.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/3/25.
//

import Foundation
import Combine

extension FileView {
    class ViewModel: BaseViewModel {
        @Service(\.fileStorageManager)
        private var fileStorageManager
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
            DispatchQueue.main.async {
                self.navigation.push(Coordinator.Navigation.subView)
            }
        }
        
        func addNewFolder() {
            rootFile.createSubfolder(child: "Foldername")
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        self.coordinator.alert = .error(title: "Error", message: error.localizedDescription)
                    }
                }, receiveValue: { })
                .store(in: cancelBag)
        }
        
        func addNewFile() {
            let string = "abcxyz"
            let data: Data = string.data(using: .utf8)!
            
            rootFile.createFile(from: data, name: "name", type: .plainText)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        self.coordinator.alert = .error(title: "Error", message: error.localizedDescription)
                    }
                }, receiveValue: { })
                .store(in: cancelBag)
        }
    }
}
