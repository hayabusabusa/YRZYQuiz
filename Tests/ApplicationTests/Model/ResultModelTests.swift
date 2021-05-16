//
//  ResultModelTests.swift
//  
//
//  Created by Shunya Yamada on 2021/05/16.
//

import Application
import XCTest
import Shared

final class ResultModelTests: XCTestCase {
    
    func test_モックを利用して保存ができることを確認() {
        let stub = [
            QuizResult(quiz: Quiz(question: "TEST", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"]),
                       isCorrect: true)
        ]
        let provider = MockUserDefaultsProvider()
        let model = ResultModel(provider: provider)
        
        model.save(results: stub)
        
        let stored = provider.value(StoredResult.self, forKey: .result)!
        XCTAssertEqual(stored.numberOfAnswered, 1)
        XCTAssertEqual(stored.numberOfCorrect, 1)
        XCTAssertEqual(stored.percent, 100)
    }
    
    func test_保存した内容が正しいことを確認() {
        let stub = [
            QuizResult(quiz: Quiz(question: "TEST", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"]),
                       isCorrect: true),
            QuizResult(quiz: Quiz(question: "TEST", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"]),
                       isCorrect: false)
        ]
        let provider = MockUserDefaultsProvider()
        let model = ResultModel(provider: provider)
        
        XCTContext.runActivity(named: "初回保存時はそのまま結果が保存されること") { _ in
            model.save(results: stub)
            
            let stored = provider.value(StoredResult.self, forKey: .result)!
            XCTAssertEqual(stored.numberOfAnswered, 2)
            XCTAssertEqual(stored.numberOfCorrect, 1)
            XCTAssertEqual(stored.percent, 50)
        }
        
        XCTContext.runActivity(named: "二回目以降は初回保存時の内容が更新されること") { _ in
            model.save(results: stub)
            
            let stored = provider.value(StoredResult.self, forKey: .result)!
            XCTAssertEqual(stored.numberOfAnswered, 4)
            XCTAssertEqual(stored.numberOfCorrect, 2)
            XCTAssertEqual(stored.percent, 50)
        }
    }
}
