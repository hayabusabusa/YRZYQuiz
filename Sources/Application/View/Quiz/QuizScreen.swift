//
//  SwiftUIView.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import SwiftUI
import UIComponents

public struct QuizScreen: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            // MARK: Texts VStack
            VStack(alignment: .leading, spacing: 12.0) {
                Text("第1問 雑学")
                    .font(.callout)
                    .foregroundColor(.gray)
                Text("オタマジャクシからカエルに変わることを何という？")
                    .font(.title3)
                    .bold()
                RateView(rate: 2)
            }

            // MARK: Flexible Spacer
            Spacer()
            
            // MARK: Buttons VStack
            VStack(spacing: 12.0) {
                OutlinedButton(action: {}, label: "進化")
                OutlinedButton(action: {}, label: "変態")
                OutlinedButton(action: {}, label: "変化")
            }
        }
        .padding(.all, 24)
    }
}

struct QuizScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizScreen()
    }
}
