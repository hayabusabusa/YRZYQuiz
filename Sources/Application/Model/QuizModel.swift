//
//  File.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import Combine
import Domain
import Foundation
import Shared

public protocol QuizModelProtocol {
    var quizzesPublisher: AnyPublisher<[Quiz], Never> { get }
    var errorPublisher: AnyPublisher<Error, Never> { get }
    func fetchQuizzes()
}

public final class QuizModel: QuizModelProtocol {
    
    private let client: APIClientProtocol
    
    private let quizzesSubject: CurrentValueSubject<[Quiz], Never>
    public let quizzesPublisher: AnyPublisher<[Quiz], Never>
    
    private let errorSubject: PassthroughSubject<Error, Never>
    public let errorPublisher: AnyPublisher<Error, Never>
    
    public init(client: APIClientProtocol = APIClient.shared) {
        self.client = client
        self.quizzesSubject = CurrentValueSubject<[Quiz], Never>([])
        self.quizzesPublisher = quizzesSubject.eraseToAnyPublisher()
        self.errorSubject = PassthroughSubject<Error, Never>()
        self.errorPublisher = errorSubject.eraseToAnyPublisher()
    }
    
    public func fetchQuizzes() {
        client.call(with: GetJsonRequest()) { [weak self] result in
            switch result {
            case .success(let response):
                var shuffledQuizzes = response.quizzes
                shuffledQuizzes.shuffle()
                
                self?.quizzesSubject.send(shuffledQuizzes)
            case .failure(let error):
                self?.errorSubject.send(error)
            }
        }
    }
}
