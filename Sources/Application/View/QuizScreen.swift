//
//  QuizScreen.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import SwiftUI
import UIComponents

public struct QuizScreen: View {
    @StateObject private var viewModel = QuizViewModel()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack {
                // MARK: Texts VStack
                VStack(alignment: .leading, spacing: 12.0) {
                    Text("第\(viewModel.index)問 \(viewModel.quiz.genre)")
                        .font(.callout)
                        .foregroundColor(.gray)
                    HStack {
                        Text(viewModel.quiz.question)
                            .font(.title3)
                            .bold()
                        // NOTE: `HStack` と `Spacer` を使ってテキスト部分を画面いっぱいまで広げる
                        Spacer()
                    }
                    RateView(rate: viewModel.quiz.difficulty)
                }
                
                // MARK: Flexible Spacer
                Spacer()
                
                // MARK: Buttons VStack
                VStack(spacing: 12.0) {
                    ForEach(viewModel.quiz.choices, id: \.self) { choice in
                        OutlinedButton(action: {
                            viewModel.onTapChoiceButton(choice: choice)
                        }, label: choice)
                    }
                }
            }
            .padding(.all, 24)
            .navigationBarTitle("問題", displayMode: .inline)
            .alert(isPresented: $viewModel.isFinish, content: {
                Alert(title: Text(""), message: Text("終了"))
            })
        }
    }
}

struct QuizScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizScreen()
    }
}
