//
//  QuizScreen.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import SwiftUI
import UIComponents

public struct QuizScreen: View {
    @Environment(\.presentationMode) var presentationMode
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
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: ZStack(alignment: .topLeading) {
                // MARK: NavigationBar title
                
                // NOTE: UIKit の `UINavigationBar.titleView` みたいなものはないので、
                // `ZStack` で重ねて `padding()` で位置を微調整する.
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                })
                .padding(EdgeInsets(top: 4, leading: 12, bottom: 0, trailing: 0))
                
                ProgressBar(value: $viewModel.index, max: 10)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 56)
            })
            .fullScreenCover(isPresented: $viewModel.isFinish, onDismiss: {
                presentationMode.wrappedValue.dismiss()
            }) {
                ResultScreen(results: viewModel.results)
            }
        }
    }
}

struct QuizScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizScreen()
    }
}
