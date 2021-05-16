//
//  ResultScreen.swift
//  
//
//  Created by Shunya Yamada on 2021/05/12.
//

import SwiftUI
import UIComponents
import Shared

public struct ResultScreen: View {
    @Environment(\.presentationMode) private var presentationMode
    private let results: [QuizResult]
    private let viewModel = ResultViewModel()
    
    public init(results: [QuizResult]) {
        self.results = results
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    // MARK: Header
                    ResultHeader(percent: percent, percentColor: .green, numberOfQuiz: results.count, numberOfCorrect: numberOfCorrects, action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    .background(Color(UIColor.systemBackground))
                    
                    // MARK: Separator
                    ResultSeparator(title: "問題一覧", showLine: false)
                    
                    // MARK: Cells
                    ForEach(0 ..< results.count) { index in
                        ResultCell(title: results[index].quiz.question, answer: results[index].quiz.answer, isCorrect: results[index].isCorrect)
                            .background(Color(UIColor.systemBackground))
                    }
                }
                // NOTE: 一応画面下のインセットを追加
                .padding(.bottom, 24)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("結果")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            viewModel.onAppear(results: results)
        })
    }
}

extension ResultScreen {
    
    private var percent: String {
        return "\(Int(Double(numberOfCorrects) / Double(results.count) * 100))"
    }
    
    private var numberOfCorrects: Int {
        return results.filter { $0.isCorrect }.count
    }
}

struct ResultScreen_Previews: PreviewProvider {
    static let results = [
        QuizResult(quiz: Quiz(
                    question: "テストの質問文",
                    genre: "TEST",
                    difficulty: 2,
                    answer: "TEST",
                    choices: [
                        "TEST"
                    ]),
                   isCorrect: true)
    ]
    
    static var previews: some View {
        ResultScreen(results: results)
    }
}
