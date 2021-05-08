//
//  QuizTests.swift
//  
//
//  Created by Shunya Yamada on 2021/05/07.
//

import XCTest
@testable import Shared

final class QuizTests: XCTestCase {
    
    func test_JSONからデコードできることを確認() {
        let json = """
        {
            "quizzes": [
                {
                    "question": "4月3日は、「いんげん豆の日」だそうです。「いんげん」という名前の由来となったのは、次のうちどれでしょう？",
                    "genre": "雑学",
                    "difficulty": 2,
                    "answer": "人の名前",
                    "choices": [
                        "国の名前",
                        "人の名前",
                        "漢詩の一部"
                    ]
                },
                {
                    "question": "緑色の「さやいんげん」は、煮豆などに使う乾物の「いんげん」と同じいんげん豆の種類の一つである。〇か×か",
                    "genre": "雑学",
                    "difficulty": 3,
                    "answer": "○",
                    "choices": [
                        "○",
                        "✖︎"
                    ]
                }
            ]
        }
        """.data(using: .utf8)!
        
        let quizzes = try? JSONDecoder().decode(Quizzes.self, from: json)
        let quiz = quizzes?.quizzes.first
        
        XCTAssertEqual(quiz?.question, "4月3日は、「いんげん豆の日」だそうです。「いんげん」という名前の由来となったのは、次のうちどれでしょう？")
        XCTAssertEqual(quiz?.genre, "雑学")
        XCTAssertEqual(quiz?.difficulty, 2)
        XCTAssertEqual(quiz?.answer, "人の名前")
        XCTAssertEqual(quiz?.choices, ["国の名前", "人の名前", "漢詩の一部"])
    }
    
    func test_イニシャライザの確認() {
        let quiz = Quiz(question: "TEST", genre: "TEST", difficulty: 0, answer: "TEST", choices: ["TEST"])
        let quizzes = Quizzes(quizzes: [quiz])
        
        XCTAssertEqual(quiz.question, "TEST")
        XCTAssertEqual(quiz.genre, "TEST")
        XCTAssertEqual(quiz.difficulty, 0)
        XCTAssertEqual(quiz.answer, "TEST")
        XCTAssertEqual(quiz.choices, ["TEST"])
        XCTAssertEqual(quizzes.quizzes.count, 1)
    }
}
