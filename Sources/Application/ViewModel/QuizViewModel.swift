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
    private var cancellables: [AnyCancellable] = []
    
    @Published public var quiz: Quiz? = nil
    
    init(model: QuizModelProtocol = QuizModel()) {
        self.model = model
        bind()
    }
}

extension QuizViewModel {
    
    private func bind() {
        let quizzesSubscriber = model.quizzesPublisher
            .map { $0.first }
            .subscribe(on: RunLoop.main)
            .assign(to: \.quiz, on: self)
        
        cancellables += [
            quizzesSubscriber
        ]
        
        model.fetchQuizzes()
    }
}
