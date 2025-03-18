//
//  FileItemView.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 17/3/25.
//

import SwiftUI

struct FileItemView: View {
    
    var item: FileItem
    var onSelected: (FileItem) -> Void
    
    var body: some View {
        Button {
            onSelected(item)
        } label: {
            Text(item.name)
                .frame(maxWidth: .infinity)
                .frame(height: 30)
        }
    }
}

#Preview {
    FileItemView(item: .init(from: "CacheFile")!, onSelected: { _ in })
}
