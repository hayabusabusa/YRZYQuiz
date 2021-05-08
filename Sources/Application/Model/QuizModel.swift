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
    var quizzesPublisher: AnyPublisher<[Quiz], Error> { get }
    func fetchQuizzes()
}

public final class QuizModel: QuizModelProtocol {
    
    private let client: APIClientProtocol
    
    private let quizzesSubject: CurrentValueSubject<[Quiz], Error>
    public let quizzesPublisher: AnyPublisher<[Quiz], Error>
    
    public init(client: APIClientProtocol = APIClient.shared) {
        self.client = client
        self.quizzesSubject = CurrentValueSubject<[Quiz], Error>([])
        self.quizzesPublisher = quizzesSubject.eraseToAnyPublisher()
    }
    
    public func fetchQuizzes() {
        client.call(with: GetJsonRequest()) { [weak self] result in
            switch result {
            case .success(let response):
                self?.quizzesSubject.send(response.quizzes)
            case .failure(let error):
                self?.quizzesSubject.send(completion: .failure(error))
            }
        }
    }
}
