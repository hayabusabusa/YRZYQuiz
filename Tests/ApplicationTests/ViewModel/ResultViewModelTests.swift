//
//  ResultViewModelTests.swift
//  
//
//  Created by Shunya Yamada on 2021/05/16.
//

import Application
import Shared
import XCTest

final class ResultViewModelTests: XCTestCase {
    
    func test_画面表示時に結果を保存することを確認() {
        let stub = [
            QuizResult(quiz: Quiz(question: "TEST", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"]),
                       isCorrect: true),
            QuizResult(quiz: Quiz(question: "TEST", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"]),
                       isCorrect: false)
        ]
        let provider = MockUserDefaultsProvider()
        let model = ResultModel(provider: provider)
        let viewModel = ResultViewModel(model: model)
        
        XCTContext.runActivity(named: "初回保存時はそのまま結果が保存されること") { _ in
            viewModel.onAppear(results: stub)
            
            let stored = provider.value(StoredResult.self, forKey: .result)!
            XCTAssertEqual(stored.numberOfAnswered, 2)
            XCTAssertEqual(stored.numberOfCorrect, 1)
            XCTAssertEqual(stored.percent, 50)
        }
        
        XCTContext.runActivity(named: "二回目以降は初回保存時の内容が更新されること") { _ in
            viewModel.onAppear(results: stub)
            
            let stored = provider.value(StoredResult.self, forKey: .result)!
            XCTAssertEqual(stored.numberOfAnswered, 4)
            XCTAssertEqual(stored.numberOfCorrect, 2)
            XCTAssertEqual(stored.percent, 50)
        }
    }
}
