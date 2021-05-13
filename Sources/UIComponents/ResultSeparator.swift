//
//  ResultSeparator.swift
//  
//
//  Created by Shunya Yamada on 2021/05/13.
//

import SwiftUI

public struct ResultSeparator: View {
    let title: String
    let showLine: Bool
    
    public init(title: String, showLine: Bool = true) {
        self.title = title
        self.showLine = showLine
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if showLine {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.6))
            }
            
            HStack {
                Text(title)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(EdgeInsets(top: 24, leading: 24, bottom: 12, trailing: 24))
            
            if showLine {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.6))
            }
        }
    }
}

struct ResultSeparator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultSeparator(title: "ラインありのセクション")
            ResultSeparator(title: "ラインなしのセクション", showLine: false)
            ResultSeparator(title: "ダークモードのセクション")
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 320, height: 64))
    }
}
