//
//  Quiz.swift
//  
//
//  Created by Shunya Yamada on 2021/05/07.
//

import Foundation

public struct Quiz: Decodable, Equatable {
    /// 問題文
    public let question: String
    /// 問題のジャンル
    public let genre: String
    /// 難易度
    public let difficulty: Int
    /// 答え
    public let answer: String
    /// 選択肢
    public let choices: [String]
    
    public init(question: String,
                genre: String,
                difficulty: Int,
                answer: String,
                choices: [String]) {
       self.question = question
       self.genre = genre
       self.difficulty = difficulty
       self.answer = answer
       self.choices = choices
   }
}
