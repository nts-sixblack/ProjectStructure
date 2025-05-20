//
//  DataView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/2/25.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            VStack {
                switch viewModel.persons {
                case .notRequested:
                    Text("Loading").onAppear { viewModel.getPerson() }
                case let .isLoading(last, _):
                    loadingView(last)
                case let .loaded(persons):
                    loadedView(persons)
                case let .failed(error):
                    Text(error.localizedDescription)
                }
                
                Text("Content")
                    .font(FontFamily.Roboto.black.textStyle(.caption))
                
                Text("Content")
                    .font(FontFamily.Roboto.boldItalic.font(fixedSize: 18))
                
                Text("Content")
                    .font(FontFamily.Roboto.boldItalic.font(size: 18, relativeTo: .caption2))
            }
        }
    }
}

extension DataView {
    @ViewBuilder
    func loadingView(_ previouslyLoaded: LazyList<Person>?) -> some View {
        VStack {
            if let persons = previouslyLoaded {
                loadedView(persons)
            }
        }
    }
    
    @ViewBuilder
    func loadedView(_ persons: LazyList<Person>) -> some View {
        VStack {
            ForEach(persons, id: \.id) { item in
                Text(item.name)
                Divider()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    DataView(viewModel: .init())
}
