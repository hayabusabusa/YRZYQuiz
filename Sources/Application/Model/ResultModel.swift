//
//  ResultModel.swift
//  
//
//  Created by Shunya Yamada on 2021/05/16.
//

import Domain
import Foundation
import Shared

public protocol ResultModelProtocol: AnyObject {
    func save(result: StoredResult)
}

public final class ResultModel: ResultModelProtocol {
    
    // MARK: Dependency
    
    private let provider: UserDefaultsProviderProtocol
    
    // MARK: Initializer
    
    public init(provider: UserDefaultsProviderProtocol) {
        self.provider = provider
    }
    
    public func save(result: StoredResult) {
        provider.set(result, forKey: .result)
    }
}
