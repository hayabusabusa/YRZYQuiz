//
//  QuizModel.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import Combine
import Domain
import Foundation
import Shared

public protocol QuizModelProtocol {
    var indexPublisher: AnyPublisher<Int, Never> { get }
    var quizPublisher: AnyPublisher<Quiz, Never> { get }
    var isCorrectPublisher: AnyPublisher<Bool, Never> { get }
    var isFinishPublisher: AnyPublisher<Bool, Never> { get }
    func fetchQuizzes()
    func answer(choice: String)
}

public final class QuizModel: QuizModelProtocol {
    
    private let client: APIClientProtocol
    private let isShuffled: Bool
    
    private var quizzes: [Quiz] = []
    
    private let indexSubject: CurrentValueSubject<Int, Never>
    public let indexPublisher: AnyPublisher<Int, Never>
    
    private let quizSubject: PassthroughSubject<Quiz, Never>
    public let quizPublisher: AnyPublisher<Quiz, Never>
    
    private var isCorrectSubject: PassthroughSubject<Bool, Never>
    public let isCorrectPublisher: AnyPublisher<Bool, Never>
    
    private var isFinishSubject: PassthroughSubject<Bool, Never>
    public let isFinishPublisher: AnyPublisher<Bool, Never>
    
    public init(client: APIClientProtocol = APIClient.shared, isShuffled: Bool = true) {
        self.client = client
        self.isShuffled = isShuffled
        
        self.indexSubject = CurrentValueSubject<Int, Never>(0)
        self.indexPublisher = indexSubject.eraseToAnyPublisher()
        
        self.quizSubject = PassthroughSubject<Quiz, Never>()
        self.quizPublisher = quizSubject.eraseToAnyPublisher()
        
        self.isCorrectSubject = PassthroughSubject<Bool, Never>()
        self.isCorrectPublisher = isCorrectSubject.eraseToAnyPublisher()
        
        self.isFinishSubject = PassthroughSubject<Bool, Never>()
        self.isFinishPublisher = isFinishSubject.eraseToAnyPublisher()
    }
    
    public func fetchQuizzes() {
        client.call(with: GetJsonRequest()) { [weak self] result in
            switch result {
            case .success(let response):
                var quizzes = response.quizzes
                
                if self?.isShuffled ?? true {
                    let shuffled = quizzes.shuffled().map { quiz -> Quiz in
                        let shuffledChoices = quiz.choices.shuffled()
                        return Quiz(question: quiz.question, genre: quiz.genre, difficulty: quiz.difficulty, answer: quiz.answer, choices: shuffledChoices)
                    }
                    quizzes = shuffled
                }
                
                // NOTE: 1問も存在しない場合は考慮しない.
                guard let quiz = quizzes.first else {
                    fatalError("[LOGIC ERROR]: クイズが1問も存在しない.")
                }
                
                self?.quizzes = quizzes
                self?.quizSubject.send(quiz)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    public func answer(choice: String) {
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
