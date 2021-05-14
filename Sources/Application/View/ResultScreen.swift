//
//  ResultScreen.swift
//  
//
//  Created by Shunya Yamada on 2021/05/12.
//

import SwiftUI
import UIComponents

public struct ResultScreen: View {
    public init() {}
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    // MARK: Header
                    ResultHeader(percent: "100", percentColor: .green, numberOfQuiz: 10, numberOfCorrect: 10, action: {})
                        .background(Color(UIColor.systemBackground))
                    
                    // MARK: Separator
                    ResultSeparator(title: "問題一覧", showLine: false)
                    
                    // MARK: Cells
                    ForEach(0 ..< 10) { index in
                        ResultCell(title: "This is TEST data. Index \(index)", answer: "index \(index)", isCorrect: index % 2 == 0)
                            .background(Color(UIColor.systemBackground))
                    }
                }
                // NOTE: 一応画面下のインセットを追加
                .padding(.bottom, 16)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("結果")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreen()
    }
}
