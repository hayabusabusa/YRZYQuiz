//
//  QuizViewModelTests.swift
//  
//
//  Created by Shunya Yamada on 2021/05/12.
//

import Application
import Combine
import Shared
import XCTest

final class QuizViewModelTests: XCTestCase {
    
    func test_初期化時にフェッチを行い1問目が正しく流れることを確認() {
        let stub = [
            Quiz(question: "TEST", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"])
        ]
        let model = MockQuizModel(quizzes: stub)
        let viewModel = QuizViewModel(model: model)
        
        let expectedValue = stub
        let result = expectValue(of: viewModel.$quiz, equals: expectedValue)
        
        wait(for: [result.expectation], timeout: 0.1)
    }
    
    func test_解答時の動作が正しいことを確認() {
        let stub = [
            Quiz(question: "TEST1", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"]),
            Quiz(question: "TEST2", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"])
        ]
        let model = MockQuizModel(quizzes: stub)
    
        XCTContext.runActivity(named: "解答後は次の問題が流れること") { _ in
            let viewModel = QuizViewModel(model: model)
            
            let expectedValues = stub
            let result = expectValue(of: viewModel.$quiz, equals: expectedValues)
            
            viewModel.onTapChoiceButton(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 0.1)
        }
        
        XCTContext.runActivity(named: "解答後は現在の問題番号が更新されて流れてくること") { _ in
            let viewModel = QuizViewModel(model: model)
            
            // NOTE: `@Published public var index = 0` の初期値はこのタイミングでは遅すぎて流れない？
            let expectedValues = [2]
            let result = expectValue(of: viewModel.$index, equals: expectedValues)
            
            viewModel.onTapChoiceButton(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 0.1)
        }
        
        XCTContext.runActivity(named: "最終問題まで答えるとフラグが True で流れてくること") { _ in
            let viewModel = QuizViewModel(model: model)
            
            let expectedValues = [true]
            let result = expectValue(of: viewModel.$isFinish, equals: expectedValues)
            
            viewModel.onTapChoiceButton(choice: "TEST")
            viewModel.onTapChoiceButton(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 0.1)
        }
    }
    
    func test_クイズの結果が正しく返されることを確認() {
        let stub = [
            Quiz(question: "TEST1", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"]),
            Quiz(question: "TEST2", genre: "TEST", difficulty: 1, answer: "TEST", choices: ["TEST"])
        ]
        let model = MockQuizModel(quizzes: stub)
        
        // NOTE: クイズが正解したか不正解だったかを想定.
        let expression = [
            true,
            false
        ]
        // NOTE: これ参照型だったから？同じ `QuizViewModel` が参照されて結果がリセットされていなかったので、別テストで作成.
        let viewModel = QuizViewModel(model: model)
        
        viewModel.onTapChoiceButton(choice: "TEST")
        viewModel.onTapChoiceButton(choice: "INCORRECT")
        
        // NOTE: 正解したか不正解だったかのみを比較.
        XCTAssertEqual(viewModel.results.map { $0.isCorrect }, expression)
    }
}
