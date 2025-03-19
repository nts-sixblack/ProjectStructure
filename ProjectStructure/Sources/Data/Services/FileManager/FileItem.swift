//
//  FileItem.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 16/3/25.
//

import Foundation
import Combine
import UniformTypeIdentifiers

struct FileItem {
    let id: UUID = UUID()
    var name: String
    var isDirectory: Bool
    var createTime: Double
    var url: URL
    var children: [FileItem]
    var selected: Bool
    
    // Tính toán các giá trị
    var countFile: Int { children.count { !$0.isDirectory } }
    var selectedFiles: [FileItem] { children.filter { !$0.isDirectory && $0.selected } }
    var selectedFolder: [FileItem] { children.filter { $0.isDirectory && $0.selected } }
    
    init(name: String, isDirectory: Bool, createTime: Double, lastModified: Double, url: URL, children: [FileItem], selected: Bool) {
        self.name = name
        self.isDirectory = isDirectory
        self.createTime = createTime
        self.url = url
        self.children = children
        self.selected = selected
    }
    
    // Khởi tạo từ thư mục
    init?(from folder: String) {
        let url = URL.documentUrl.appendingPathComponent(folder, isDirectory: true)
        self.init(from: url)
    }
    
    // Khởi tạo từ URL
    init?(from url: URL) {
        self.url = url
        self.name = url.lastPathComponent
        let manager = FileManager.default
        
        if url.isExists {
            self.isDirectory = url.isDirectory
            if let att = try? manager.attributesOfItem(atPath: url.path),
               let date = att[FileAttributeKey.creationDate] as? NSDate {
                self.createTime = date.timeIntervalSince1970
            } else {
                self.createTime = Date().timeIntervalSince1970
            }
            self.selected = false
            if isDirectory {
                if let items = try? manager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants) {
                    self.children = items.compactMap { FileItem(from: $0) }.sorted(by: >)
                } else {
                    self.children = []
                }
            } else {
                self.children = []
            }
        } else {
            do {
                try manager.createDirectory(at: url, withIntermediateDirectories: true)
                self.isDirectory = true
                self.createTime = Date().timeIntervalSince1970
                self.children = []
                self.selected = false
            } catch {
                return nil
            }
        }
    }
}

extension FileItem: Comparable {
    static func < (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime < rhs.createTime }
    
    static func <= (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime <= rhs.createTime }
    
    static func >= (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime >= rhs.createTime }
    
    static func > (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime > rhs.createTime }
    
    static func == (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime == rhs.createTime }
}
