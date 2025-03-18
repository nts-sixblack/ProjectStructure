//
//  URL.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 16/3/25.
//

import Foundation
import UniformTypeIdentifiers

extension URL {
    
    static var documentUrl: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static var cacheUrl: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var filename: String {
        deletingPathExtension().lastPathComponent
    }
    
    var nonExistsFile: URL {
        var url = self.appendingPathComponent(UUID().uuidString)
        while FileManager.default.fileExists(atPath: url.path) {
            url = self.appendingPathComponent(UUID().uuidString)
        }
        return url
    }
    
    var isExists: Bool {
        FileManager.default.fileExists(atPath: path)
    }
    
    var isDirectory: Bool {
        var isDirectory: ObjCBool = true
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
    init?(string: String?) {
        if let string = string {
            self.init(string: string)
        } else {
            return nil
        }
    }
    
    func nextFolder(name: String) -> URL {
        let validName = name.convertToValidFileName()
        var url = self.appendingPathComponent(validName, isDirectory: true)
        var index = 0
        var newName = validName
        while url.isExists {
            index += 1
            newName = "\(validName)_(\(index))"
            url = self.appendingPathComponent(newName, isDirectory: true)
        }
        return url
    }
    
    func nextFile(name: String, type: UTType) -> URL {
        let validName = name.convertToValidFileName()
        var url = self.appendingPathComponent(validName, isDirectory: false).appendingPathExtension(for: type)
        var index = 0
        var newName = validName
        while url.isExists {
            index += 1
            newName = "\(validName)_(\(index))"
            url = self.appendingPathComponent(newName, isDirectory: false).appendingPathExtension(for: type)
        }
        return url
    }
    
    var utType: UTType {
        if let typeIdentifier = try? self.resourceValues(forKeys: [.typeIdentifierKey]).typeIdentifier,
           let utType = UTType(typeIdentifier) {
            return utType
        }
        return .data // Default type
    }
    
    static func documentsDirectory() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        .appendingPathComponent("Media Vault", isDirectory: true)
        .appendingPathComponent("Wireless Transfer", isDirectory: true)
    }
    
    func visibleContents() throws -> [URL] {
        try FileManager.default.contentsOfDirectory(
            at: self,
            includingPropertiesForKeys: nil,
            options: .skipsHiddenFiles)
    }
    
}
