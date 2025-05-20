//
//  FileView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/3/25.
//

import SwiftUI

struct FileView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            VStack {
                Text(viewModel.rootFile.name)
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.rootFile.children, id: \.createTime) { item in
                            FileItemView(item: item, onSelected: viewModel.onSelectedItem(item:))
                        }
                    }
                }
            }
            .popup(item: $viewModel.coordinator.alert) { item in
                switch item {
                case let .error(title, message):
                    CustomAlertView(
                        title: title,
                        titleColor: .red,
                        description: message,
                        primaryActionTitle: "OK",
                        primaryAction: {
                            viewModel.coordinator.alert = nil
                        })
                    
                case let .success(title, message):
                    CustomAlertView(
                        title: title,
                        description: message,
                        cancelActionTitle: "Cancel",
                        cancelAction: {
                            print("cancel")
                            viewModel.coordinator.alert = nil
                        },
                        primaryActionTitle: "OK",
                        primaryAction: {
                            viewModel.coordinator.alert = nil
                        }
                    )
                }
            } customize: {
                $0.centerPopup()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.addNewFolder()
                } label: {
                    Text("Add new folder")
                }

                Button {
                    viewModel.addNewFile()
                } label: {
                    Text("Add new file")
                }

            }
        }
        .flowDestination(for: Coordinator.Navigation.self) { item in
            switch item {
            case .subView:
                if let file = viewModel.selectedFile {
                    FileView(viewModel: .init(rootFile: FileItem(from: file.url)))
                } else {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    FileView(viewModel: .init(rootFile: .init(from: "CacheFile")!))
}
