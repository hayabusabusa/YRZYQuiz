//
//  StoredResult.swift
//  
//
//  Created by Shunya Yamada on 2021/05/16.
//

import Foundation

public struct StoredResult: Codable {
    public let numberOfAnswered: Int
    public let numberOfCorrect: Int
    public let percent: Int
    
    public init(numberOfAnswered: Int, numberOfCorrect: Int, percent: Int) {
        self.numberOfAnswered = numberOfAnswered
        self.numberOfCorrect = numberOfCorrect
        self.percent = percent
    }
}
