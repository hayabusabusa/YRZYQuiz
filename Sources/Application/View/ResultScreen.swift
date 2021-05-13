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
                LazyVStack {
                    ResultHeader(percent: "100", percentColor: .green, numberOfQuiz: 10, numberOfCorrect: 10, action: {})
                    ForEach(0 ..< 10) { index in
                        ResultCell(title: "This is TEST data. Index \(index)", answer: "index \(index)", isCorrect: index % 2 == 0)
                    }
                }
            }
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
