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
    func save(results: [QuizResult])
}

public final class ResultModel: ResultModelProtocol {
    
    // MARK: Dependency
    
    private let provider: UserDefaultsProviderProtocol
    
    // MARK: Initializer
    
    public init(provider: UserDefaultsProviderProtocol = UserDefaultsProvider.shared) {
        self.provider = provider
    }
    
    public func save(results: [QuizResult]) {
        let numberOfAnswered = results.count
        let numberOfCorrect = results.filter { $0.isCorrect }.count
        
        if let stored = provider.value(StoredResult.self, forKey: .result) {
            let newNumberOfAnswered = stored.numberOfAnswered + numberOfAnswered
            let newNumberOfCorrect = stored.numberOfCorrect + numberOfCorrect
            let percent = Int(Double(newNumberOfCorrect) / Double(newNumberOfAnswered) * 100)
            
            let newResult = StoredResult(numberOfAnswered: newNumberOfAnswered, numberOfCorrect: newNumberOfCorrect, percent: percent)
            provider.set(newResult, forKey: .result)
        } else {
            let percent = Int(Double(numberOfCorrect) / Double(numberOfAnswered) * 100)
            provider.set(StoredResult(numberOfAnswered: numberOfAnswered, numberOfCorrect: numberOfCorrect, percent: percent), forKey: .result)
        }
    }
}
