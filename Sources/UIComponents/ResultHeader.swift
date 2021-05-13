//
//  ResultHeader.swift
//  
//
//  Created by Shunya Yamada on 2021/05/13.
//

import SwiftUI

public struct ResultHeader: View {
    let percent: String
    let percentColor: Color
    let numberOfQuiz: Int
    let numberOfCorrect: Int
    let action: () -> Void
    
    public init(percent: String, percentColor: Color, numberOfQuiz: Int, numberOfCorrect: Int, action: @escaping () -> Void) {
        self.percent = percent
        self.percentColor = percentColor
        self.numberOfQuiz = numberOfQuiz
        self.numberOfCorrect = numberOfCorrect
        self.action = action
    }
    
    public var body: some View {
        VStack {
            Text("正解率は...")
                .font(.caption)
            Text("\(percent)%")
                .font(.system(size: 40))
                .bold()
                .foregroundColor(percentColor)
            Text("\(numberOfQuiz)問中\(numberOfCorrect)問正解でした。")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Spacer()
                .frame(height: 16)
            
            Button(action: action, label: {
                HStack {
                    Spacer()
                    Text("最初の画面に戻る")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(Color.blue)
                .cornerRadius(4.0)
            })
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
    }
}

struct ResultHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultHeader(percent: "100", percentColor: .green, numberOfQuiz: 10, numberOfCorrect: 10, action: {})
            ResultHeader(percent: "100", percentColor: .green, numberOfQuiz: 10, numberOfCorrect: 10, action: {})
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 320, height: 200))
    }
}
