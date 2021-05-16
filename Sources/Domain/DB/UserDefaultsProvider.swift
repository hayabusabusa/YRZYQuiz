//
//  UserDefaultsProvider.swift
//  
//
//  Created by Shunya Yamada on 2021/05/16.
//

import Foundation

public protocol UserDefaultsProviderProtocol: AnyObject {
    func value<T: Decodable>(_ decodableType: T.Type, forKey name: UserDefaultsProvider.Key) -> T?
    func set<T: Encodable>(_ encodableValue: T, forKey name: UserDefaultsProvider.Key)
}

public final class UserDefaultsProvider: UserDefaultsProviderProtocol {
    
    public static let shared: UserDefaultsProvider = .init()
    
    private var userDefaults: UserDefaults
    
    private init() {
        guard let userDefaults = UserDefaults(suiteName: "ShunyaYamada.YRZYQuiz.AppGroups") else {
            fatalError("AppGroups may be not configured.")
        }
        self.userDefaults = userDefaults
    }
    
    public enum Key: String {
        case result
    }
    
    public func value<T: Decodable>(_ decodableType: T.Type, forKey name: Key) -> T? {
        guard let data = userDefaults.data(forKey: name.rawValue),
              let value = try? JSONDecoder().decode(decodableType.self, from: data) else {
            return nil
        }
        return value
    }
    
    public func set<T: Encodable>(_ encodableValue: T, forKey name: Key) {
        guard let data = try? JSONEncoder().encode(encodableValue) else {
            return
        }
        userDefaults.setValue(data, forKey: name.rawValue)
    }
}
