//
//  Quizzes.swift
//  
//
//  Created by Shunya Yamada on 2021/05/07.
//

import Foundation

public struct Quizzes: Decodable {
    public let quizzes: [Quiz]
    
    public init(quizzes: [Quiz]) {
        self.quizzes = quizzes
    }
}
