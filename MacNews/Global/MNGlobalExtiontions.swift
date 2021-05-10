//
//  MNGlobalExtiontions.swift
//  MacNews
//
//  Created by Anan Suliman on 09/05/2021.
//

import Foundation

//This extension is used to use the @AppStorege property with arrays in this app is used for bookmarking articles
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
//Predefine the Userdefultsand AppStorege keys
enum UserDefaultsKeys :String {
    case BookmarkedArticles
    case FirstOpen
}
