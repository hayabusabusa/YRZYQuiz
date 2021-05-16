//
//  MockUserDefaultsProvider.swift
//  
//
//  Created by Shunya Yamada on 2021/05/16.
//

import Domain
import Foundation

final class MockUserDefaultsProvider: UserDefaultsProviderProtocol {
    
    private var dictionary: [String: Any] = [:]
    
    func value<T>(_ decodableType: T.Type, forKey name: UserDefaultsProvider.Key) -> T? where T : Decodable {
        guard let value = dictionary[name.rawValue] as? T else {
            fatalError("Value for key named \(name.rawValue) not found.")
        }
        return value
    }
    
    func set<T>(_ encodableValue: T, forKey name: UserDefaultsProvider.Key) where T : Encodable {
        dictionary[name.rawValue] = encodableValue
    }
    
    func removeAll() {
        dictionary.removeAll()
    }
}
