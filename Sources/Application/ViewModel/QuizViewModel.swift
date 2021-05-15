//
//  QuizViewModel.swift
//  
//
//  Created by Shunya Yamada on 2021/05/09.
//

import Combine
import Foundation
import Shared

public final class QuizViewModel: ObservableObject {
    
    // MARK: Properties
    
    private let model: QuizModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Outputs
    
    @Published public var index = 0
    // NOTE: `PassthroughSubject` でも初期値が必要なのがちょっと厄介.
    // ここ素直にオプショナルにして View 側でアンラップして使う方が楽かも.
    @Published private(set) public var quiz: Quiz = Quiz(question: "", genre: "", difficulty: 0, answer: "", choices: [])
    @Published public var isFinish = false
    
    private(set) public var results: [QuizResult] = []
    
    public init(model: QuizModelProtocol = QuizModel()) {
        self.model = model
        bind()
    }
    
    // MARK: Inputs
    
    public func onTapChoiceButton(choice: String) {
        model.answer(choice: choice)
    }
}

extension QuizViewModel {
    
    private func bind() {
        model.indexPublisher
            .map { $0 + 1 }
            .assign(to: \.index, on: self)
            .store(in: &cancellables)
        
        model.quizPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.quiz, on: self)
            .store(in: &cancellables)
        
        model.resultsPublisher
            .handleEvents(receiveOutput: { [weak self] results in
                self?.results = results
            })
            .map { _ in true }
            .assign(to: \.isFinish, on: self)
            .store(in: &cancellables)
        
        model.fetchQuizzes()
    }
}
