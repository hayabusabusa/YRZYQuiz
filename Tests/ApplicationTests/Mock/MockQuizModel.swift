//
//  MockQuizModel.swift
//  
//
//  Created by Shunya Yamada on 2021/05/11.
//

import Application
import Combine
import Foundation
import Shared

final class MockQuizModel: QuizModelProtocol {
    
    private var quizzes: [Quiz] = []
    private var results: [QuizResult] = []
    
    private let indexSubject: CurrentValueSubject<Int, Never>
    public let indexPublisher: AnyPublisher<Int, Never>
    
    private let quizSubject: PassthroughSubject<Quiz, Never>
    public let quizPublisher: AnyPublisher<Quiz, Never>
    
    private let resultsSubject: PassthroughSubject<[QuizResult], Never>
    public let resultsPublisher: AnyPublisher<[QuizResult], Never>
    
    private var isCorrectSubject: PassthroughSubject<Bool, Never>
    public let isCorrectPublisher: AnyPublisher<Bool, Never>
    
    public init(quizzes: [Quiz]) {
        self.quizzes = quizzes
        self.results = []
        
        self.indexSubject = CurrentValueSubject<Int, Never>(0)
        self.indexPublisher = indexSubject.eraseToAnyPublisher()
        
        self.quizSubject = PassthroughSubject<Quiz, Never>()
        self.quizPublisher = quizSubject.eraseToAnyPublisher()
        
        self.resultsSubject = PassthroughSubject<[QuizResult], Never>()
        self.resultsPublisher = resultsSubject.eraseToAnyPublisher()
        
        self.isCorrectSubject = PassthroughSubject<Bool, Never>()
        self.isCorrectPublisher = isCorrectSubject.eraseToAnyPublisher()
    }
    
    func fetchQuizzes() {
        guard let quiz = quizzes.first else {
            fatalError("[LOGIC ERROR]: クイズが1問も存在しない.")
        }
        quizSubject.send(quiz)
    }
    
    func answer(choice: String) {
        guard quizzes.indices.contains(indexSubject.value) else {
            return
        }
        
        let answer = quizzes[indexSubject.value].answer
        let isCorrect = answer == choice
        let nextIndex = indexSubject.value + 1
        
        results.append(QuizResult(quiz: quizzes[indexSubject.value], isCorrect: isCorrect))
        
        // NOTE: 最終問題まで到達したら終了する.
        if !quizzes.indices.contains(nextIndex) {
            resultsSubject.send(results)
            return
        }
        
        isCorrectSubject.send(isCorrect)
        indexSubject.send(nextIndex)
        quizSubject.send(quizzes[nextIndex])
    }
}
