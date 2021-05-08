//
//  MockAPIRequest.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import Foundation
import Shared
@testable import Domain

struct MockAPIRequest: APIRequest {
    typealias Response = Quiz
    
    private let targetURL: String
    
    public init(targetURL: String) {
        self.targetURL = targetURL
    }
    
    var url: String {
        return targetURL
    }
    
    var stub: Response? {
        return Quiz(question: "TEST", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"])
    }
}
