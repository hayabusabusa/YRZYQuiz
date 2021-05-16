//
//  File.swift
//  
//
//  Created by Shunya Yamada on 2021/05/16.
//

import Foundation
import Shared

public final class ResultViewModel {
    
    // MARK: Dependency
    
    private let model: ResultModelProtocol
    
    // MARK: Initializer
    
    public init(model: ResultModelProtocol = ResultModel()) {
        self.model = model
    }
    
    public func onAppear(results: [QuizResult]) {
        model.save(results: results)
    }
}
