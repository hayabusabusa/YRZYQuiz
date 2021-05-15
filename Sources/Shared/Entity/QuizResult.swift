//
//  QuizResult.swift
//  
//
//  Created by Shunya Yamada on 2021/05/15.
//

import Foundation

public struct QuizResult: Equatable {
    public let quiz: Quiz
    public let isCorrect: Bool
    
    public init(quiz: Quiz, isCorrect: Bool) {
        self.quiz = quiz
        self.isCorrect = isCorrect
    }
}
