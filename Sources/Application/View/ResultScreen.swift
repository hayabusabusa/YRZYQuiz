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
                    ResultHeader(percent: "100", percentColor: .green, numberOfQuiz: 10, numberOfCorrect: 10, action: {})
                        .background(Color(UIColor.systemBackground))
                    ResultSeparator(title: "問題一覧", showLine: false)
                    ForEach(0 ..< 10) { index in
                        ResultCell(title: "This is TEST data. Index \(index)", answer: "index \(index)", isCorrect: index % 2 == 0)
                            .background(Color(UIColor.systemBackground))
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("結果")
            .navigationBarTitleDisplayMode(.inline)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ResultScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResultScreen()
    }
}
