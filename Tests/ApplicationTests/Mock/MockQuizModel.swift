//
//  MockQuizModel.swift
//  
//
//  Created by Shunya Yamada on 2021/05/11.
//

@testable import Application
import Combine
import Foundation
import Shared

final class MockQuizModel: QuizModelProtocol {
    
    private var quizzes: [Quiz] = []
    
    private let indexSubject: CurrentValueSubject<Int, Never>
    public let indexPublisher: AnyPublisher<Int, Never>
    
    private let quizSubject: PassthroughSubject<Quiz, Never>
    public let quizPublisher: AnyPublisher<Quiz, Never>
    
    private var isCorrectSubject: PassthroughSubject<Bool, Never>
    public let isCorrectPublisher: AnyPublisher<Bool, Never>
    
    private var isFinishSubject: PassthroughSubject<Bool, Never>
    public let isFinishPublisher: AnyPublisher<Bool, Never>
    
    public init() {
        self.indexSubject = CurrentValueSubject<Int, Never>(0)
        self.indexPublisher = indexSubject.eraseToAnyPublisher()
        
        self.quizSubject = PassthroughSubject<Quiz, Never>()
        self.quizPublisher = quizSubject.eraseToAnyPublisher()
        
        self.isCorrectSubject = PassthroughSubject<Bool, Never>()
        self.isCorrectPublisher = isCorrectSubject.eraseToAnyPublisher()
        
        self.isFinishSubject = PassthroughSubject<Bool, Never>()
        self.isFinishPublisher = isFinishSubject.eraseToAnyPublisher()
    }
    
    func fetchQuizzes() {
        
    }
    
    func answer(choice: String) {
        guard quizzes.indices.contains(indexSubject.value) else {
            return
        }
        
        let answer = quizzes[indexSubject.value].answer
        let isCorrect = answer == choice
        let nextIndex = indexSubject.value + 1
        
        // NOTE: 最終問題まで到達したら終了する.
        if !quizzes.indices.contains(nextIndex) {
            isFinishSubject.send(true)
            return
        }
        
        isCorrectSubject.send(isCorrect)
        indexSubject.send(nextIndex)
        quizSubject.send(quizzes[nextIndex])
    }
}
