//
//  ResultCell.swift
//  
//
//  Created by Shunya Yamada on 2021/05/12.
//

import SwiftUI

public struct ResultCell: View {
    let title: String
    let answer: String
    let isCorrect: Bool
    
    public init(title: String, answer: String, isCorrect: Bool) {
        self.title = title
        self.answer = answer
        self.isCorrect = isCorrect
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            // MARK: Title HStack
            HStack {
                Image(systemName: isCorrect ? "circle" : "xmark")
                    .frame(width: 20, height: 20)
                    .foregroundColor(isCorrect ? .green : .red)
                Text(title)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // MARK: Answer HStack
            HStack {
                Text("A")
                    .font(.system(size: 20))
                    .bold()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isCorrect ? .green : .red)
                Text(answer)
                    .bold()
                    .foregroundColor(isCorrect ? .green : .red)
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
    }
}

struct ResultCell_Previews: PreviewProvider {
    private static let shortText: String = "短い内容。"
    private static let longText: String = "テストで表示する問題の内容。内容は2行まで表示するように調整する。"
    
    static var previews: some View {
        Group {
            ResultCell(title: shortText, answer: "答えのテスト", isCorrect: true)
            ResultCell(title: longText, answer: "答えのテスト", isCorrect: true)
            ResultCell(title: longText, answer: "答えのテスト", isCorrect: false)
        }
        .previewLayout(.fixed(width: 320, height: 96))
    }
}
