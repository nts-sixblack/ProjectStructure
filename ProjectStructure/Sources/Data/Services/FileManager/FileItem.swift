//
//  FileItem.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 16/3/25.
//

import Foundation
import Combine
import UniformTypeIdentifiers

class FileItem: ObservableObject, Selectable {
    var name: String
    var createTime: Double
    var isDirectory: Bool
    var url: URL
    var children: [FileItem]
    
    var countFile: Int { children.count { $0.isDirectory ? 0 : 1 } }
    var selectedFiles: [FileItem] { children.filter { !$0.isDirectory && $0.selected } }
    var selectedFolder: [FileItem] { children.filter { $0.isDirectory && $0.selected } }
    var selected: Bool = false
    
    convenience init?(from folder: String) {
        let url = URL.documentUrl.appendingPathComponent(folder, isDirectory: true)
        self.init(from: url)
    }
    
    init?(from url: URL) {
        self.url = url
        name = url.lastPathComponent
        let manager = FileManager.default
        if url.isExists {
            isDirectory = url.isDirectory
            if let att = try? manager.attributesOfItem(atPath: url.path) {
                if let date = att[FileAttributeKey.creationDate] as? NSDate {
                    createTime = date.timeIntervalSince1970
                } else {
                    createTime = Date().timeIntervalSince1970
                }
                children = []
                if isDirectory {
                    if let items = try? manager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants) {
                        items.forEach { print($0) }
                        for item in items {
                            if let child = FileItem(from: item) {
                                children.append(child)
                            }
                        }
                    }
                    children.sort(by: >)
                }
            } else { return nil }
        } else {
            do {
                try manager.createDirectory(at: url, withIntermediateDirectories: true)
                createTime = Date().timeIntervalSince1970
                isDirectory = true
                children = []
            } catch { return nil }
        }
    }
    
    func createSubfolder(child name: String) -> AnyPublisher<Void, FileError> {
        guard isDirectory else {
            return Fail(error: FileError.notDirectory).eraseToAnyPublisher()
        }
        
        return Future { promise in
            let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            let childURL = self.url.nextFolder(name: trimmedName)
            if let newChild = FileItem(from: childURL) {
                DispatchQueue.main.async {
                    self.children.append(newChild)
                    self.children.sort(by: >)
                    self.objectWillChange.send()
                    promise(.success(()))
                }
            } else {
                promise(.failure(FileError.fileModelCreationFailed(url: childURL)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func createFile(from data: Data, name: String? = nil, type: UTType) -> AnyPublisher<Void, FileError> {
        guard isDirectory else {
            return Fail(error: FileError.notDirectory).eraseToAnyPublisher()
        }
        
        return Future { promise in
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd_HH-mm-ss"
            let fileName = name ?? "File_\(formatter.string(from: Date()))"
            let fileURL = self.url.nextFile(name: fileName, type: type)
            
            do {
                try data.write(to: fileURL)
                if let newChild = FileItem(from: fileURL) {
                    DispatchQueue.main.async {
                        self.children.append(newChild)
                        self.children.sort(by: >)
                        self.objectWillChange.send()
                        promise(.success(()))
                    }
                } else {
                    promise(.failure(FileError.fileModelCreationFailed(url: fileURL)))
                }
            } catch {
                promise(.failure(FileError.unowned(error: error)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func createFile(url: URL) -> AnyPublisher<Void, FileError> {
        guard url.startAccessingSecurityScopedResource() else {
            return Fail(error: FileError.securityScopeAccessFailed).eraseToAnyPublisher()
        }
        
        return Future { promise in
            defer {
                url.stopAccessingSecurityScopedResource()
            }
            
            guard self.isDirectory else {
                promise(.failure(FileError.notDirectory))
                return
            }
            
            let fileName = url.deletingPathExtension().lastPathComponent
            let destinationURL = self.url.nextFile(name: fileName, type: .pdf)
            let fileManager = FileManager.default
            
            do {
                try fileManager.copyItem(at: url, to: destinationURL)
                try fileManager.setAttributes([FileAttributeKey.creationDate: NSDate()], ofItemAtPath: destinationURL.path)
                
                if let newChild = FileItem(from: destinationURL) {
                    DispatchQueue.main.async {
                        self.children.append(newChild)
                        self.children.sort(by: >)
                        self.objectWillChange.send()
                        promise(.success(()))
                    }
                } else {
                    promise(.failure(FileError.fileModelCreationFailed(url: destinationURL)))
                }
            } catch {
                promise(.failure(.unowned(error: error)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func rename(to name: String) -> AnyPublisher<Void, FileError> {
        Future { promise in
            let toName = name.trimmingCharacters(in: .whitespacesAndNewlines).convertToValidFileName()
            let destinationURL = self.url.isDirectory
            ? self.url.deletingLastPathComponent().nextFolder(name: toName)
            : self.url.deletingPathExtension().nextFile(name: toName, type: self.url.utType)
            
            do {
                try FileManager.default.moveItem(at: self.url, to: destinationURL)
                
                self.url = destinationURL
                self.name = destinationURL.lastPathComponent
                
                self.children.removeAll()
                
                if self.isDirectory {
                    let items = try FileManager.default.contentsOfDirectory(at: destinationURL, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
                    self.children = items.compactMap { FileItem(from: $0) }
                    self.children.sort(by: >)
                }
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                    promise(.success(()))
                }
            } catch {
                promise(.failure(FileError.unowned(error: error)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteSelectedFiles() -> AnyPublisher<Void, FileError> {
        Future { promise in
            let filesToDelete = self.children.filter { !$0.isDirectory && $0.selected }
            do {
                for file in filesToDelete {
                    try FileManager.default.removeItem(at: file.url)
                }
                self.children.removeAll { !$0.isDirectory && $0.selected }
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                    promise(.success(()))
                }
            } catch {
                promise(.failure(.unowned(error: error)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteSelectedFolders() -> AnyPublisher<Void, FileError> {
        Future { promise in
            let foldersToDelete = self.children.filter { $0.isDirectory && $0.selected }
            do {
                for folder in foldersToDelete {
                    try FileManager.default.removeItem(at: folder.url)
                }
                self.children.removeAll { $0.isDirectory && $0.selected }
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                    promise(.success(()))
                }
            } catch {
                promise(.failure(.unowned(error: error)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func move(children: [FileItem], to parent: FileItem) -> AnyPublisher<Void, FileError> {
        Future { promise in
            for child in children {
                child.move(to: parent)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            self.children.removeAll { $0 === child }
                        case .failure(let failure):
                            promise(.failure(failure))
                        }
                    }, receiveValue: {})
                    .cancel()
            }
            
            parent.children.sort(by: >)
            DispatchQueue.main.async {
                self.objectWillChange.send()
                parent.objectWillChange.send()
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func move(to parent: FileItem) -> AnyPublisher<Void, FileError> {
        Future { promise in
            let fileName = self.url.deletingPathExtension().lastPathComponent
            let destinationURL = parent.url.nextFile(name: fileName, type: self.url.utType)
            
            do {
                try FileManager.default.moveItem(at: self.url, to: destinationURL)
                
                self.url = destinationURL
                self.name = destinationURL.deletingPathExtension().lastPathComponent
                parent.children.append(self)
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                    parent.objectWillChange.send()
                    promise(.success(()))
                }
            } catch {
                promise(.failure(.unowned(error: error)))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension FileItem: Comparable {
    static func < (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime < rhs.createTime }
    
    static func <= (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime <= rhs.createTime }
    
    static func >= (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime >= rhs.createTime }
    
    static func > (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime > rhs.createTime }
    
    static func == (lhs: FileItem, rhs: FileItem) -> Bool { lhs.createTime == rhs.createTime }
}
