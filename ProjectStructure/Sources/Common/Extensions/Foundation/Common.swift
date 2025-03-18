//
//  String.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 16/3/25.
//

import Foundation

extension String {
    
    var symbol: Character {
        guard let c = first, c.isLetter else {
            return Character("#")
        }
        return c.convertToUpperCase()
    }
    
    var withWhitespace: String {
        self.isEmpty ? "" : "\(self) "
    }
    
    func convertToValidFileName() -> String {
        return components(separatedBy: .init(charactersIn: "/:?%*|\"<>")).joined(separator: "_")
    }
    
}

extension Character {
    func convertToUpperCase() -> Character {
        if self.isUppercase {
            return self
        }
        return Character(self.uppercased())
    }
}
