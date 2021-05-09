//
//  OutlinedButton.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import SwiftUI

public struct OutlinedButton: View {
    private let action: () -> Void
    private let label: String
    private let cornerRadius: CGFloat
    private let insets: EdgeInsets
    private let lineColor: Color
    
    public init(action: @escaping () -> Void,
                label: String,
                cornerRadius: CGFloat = 4.0,
                insets: EdgeInsets = EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0),
                lineColor: Color = Color.blue) {
        self.action = action
        self.label = label
        self.insets = insets
        self.lineColor = lineColor
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(label)
                    .font(.callout)
                Spacer()
            }
            .padding(insets)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineColor)
                    .foregroundColor(.clear)
            )
        })
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OutlinedButton(action: {}, label: "ライトモード")
            OutlinedButton(action: {}, label: "ダークモード")
                .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.fixed(width: 320, height: 80))
    }
}
