//
//  QuizModelTests.swift
//  
//
//  Created by Shunya Yamada on 2021/05/09.
//

@testable import Application
import Foundation
import Shared
import XCTest

final class QuizModelTests: XCTestCase {
    
    func test_モックを使用して通信が正しく行えることを確認() {
        let stub = Quizzes(quizzes: [
            Quiz(question: "TEST", genre: "TEST", difficulty: 4, answer: "TEST", choices: ["TEST"])
        ])
        let client = MockAPIClicent(stub: stub)
        let model = QuizModel(client: client, isShuffled: false)
        
        let expectValues = stub.quizzes
        let result = expectValue(of: model.quizPublisher, equals: expectValues)
        
        model.fetchQuizzes()
        
        wait(for: [result.expectation], timeout: 1.0)
    }
    
    func test_正解時の動作が正しいことを確認() {
        let stub = Quizzes(quizzes: [
            Quiz(question: "TEST1", genre: "TEST", difficulty: 4, answer: "TEST", choices: ["TEST"]),
            Quiz(question: "TEST2", genre: "TEST", difficulty: 4, answer: "TEST", choices: ["TEST"]),
        ])
        let client = MockAPIClicent(stub: stub)
        
        XCTContext.runActivity(named: "正解した場合は次の問題が流れることを確認") { _ in
            let model = QuizModel(client: client, isShuffled: false)
            
            let expectValues = stub.quizzes
            let result = expectValue(of: model.quizPublisher, equals: expectValues)
            
            model.fetchQuizzes()
            model.answer(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 1.0)
        }
        
        XCTContext.runActivity(named: "正解した場合はインデックスが次のものに進むことを確認") { _ in
            let model = QuizModel(client: client, isShuffled: false)
            
            let expectValues = [0, 1]
            let result = expectValue(of: model.indexPublisher, equals: expectValues)
            
            model.fetchQuizzes()
            model.answer(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 1.0)
        }
        
        XCTContext.runActivity(named: "正解した場合は正解のフラグが流れることを確認") { _ in
            let model = QuizModel(client: client, isShuffled: false)
            
            let expectValues = [true]
            let result = expectValue(of: model.isCorrectPublisher, equals: expectValues)
            
            model.fetchQuizzes()
            model.answer(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 1.0)
        }
        
        XCTContext.runActivity(named: "最終問題まで到達したら問題は流れないことを確認") { _ in
            let model = QuizModel(client: client, isShuffled: false)
            
            let expectValues = stub.quizzes
            let result = expectValue(of: model.quizPublisher, equals: expectValues)
            
            model.fetchQuizzes()
            
            // NOTE: 問題数を超えて正解させる.
            model.answer(choice: "TEST")
            model.answer(choice: "TEST")
            model.answer(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 1.0)
        }
        
        XCTContext.runActivity(named: "最終問題まで到達したらインデックスは進まないことを確認") { _ in
            let model = QuizModel(client: client, isShuffled: false)
            
            let expectValues = [0, 1]
            let result = expectValue(of: model.indexPublisher, equals: expectValues)
            
            model.fetchQuizzes()
            
            // NOTE: 問題数を超えて正解させる.
            model.answer(choice: "TEST")
            model.answer(choice: "TEST")
            model.answer(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 1.0)
        }
        
        XCTContext.runActivity(named: "最終問題まで到達したら終了のフラグが流れることを確認") { _ in
            let model = QuizModel(client: client, isShuffled: false)
            
            let expectValues = [true]
            let result = expectValue(of: model.isFinishPublisher, equals: expectValues)
            
            model.fetchQuizzes()
            
            model.answer(choice: "TEST")
            model.answer(choice: "TEST")
            
            wait(for: [result.expectation], timeout: 1.0)
        }
    }
}
