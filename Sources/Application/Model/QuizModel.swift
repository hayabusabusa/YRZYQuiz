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
    var resultsPublisher: AnyPublisher<[QuizResult], Never> { get }
    var isCorrectPublisher: AnyPublisher<Bool, Never> { get }
    func fetchQuizzes()
    func answer(choice: String)
}

public final class QuizModel: QuizModelProtocol {
    
    private let client: APIClientProtocol
    private let isShuffled: Bool
    
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
    
    public init(client: APIClientProtocol = APIClient.shared, isShuffled: Bool = true) {
        self.client = client
        self.isShuffled = isShuffled
        
        self.indexSubject = CurrentValueSubject<Int, Never>(0)
        self.indexPublisher = indexSubject.eraseToAnyPublisher()
        
        self.quizSubject = PassthroughSubject<Quiz, Never>()
        self.quizPublisher = quizSubject.eraseToAnyPublisher()
        
        self.resultsSubject = PassthroughSubject<[QuizResult], Never>()
        self.resultsPublisher = resultsSubject.eraseToAnyPublisher()
        
        self.isCorrectSubject = PassthroughSubject<Bool, Never>()
        self.isCorrectPublisher = isCorrectSubject.eraseToAnyPublisher()
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
                
                // NOTE: 1?????????????????????????????????????????????.
                guard let quiz = quizzes.first else {
                    fatalError("[LOGIC ERROR]: ????????????1?????????????????????.")
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
        
        results.append(QuizResult(quiz: quizzes[indexSubject.value], isCorrect: isCorrect))
        
        // NOTE: ?????????????????????????????????????????????.
        if !quizzes.indices.contains(nextIndex) {
            resultsSubject.send(results)
            return
        }
        
        isCorrectSubject.send(isCorrect)
        indexSubject.send(nextIndex)
        quizSubject.send(quizzes[nextIndex])
    }
}
