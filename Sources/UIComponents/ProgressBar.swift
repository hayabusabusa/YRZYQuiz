//
//  ProgressBar.swift
//  
//
//  Created by Shunya Yamada on 2021/05/07.
//

import SwiftUI

public struct ProgressBar: View {
    private let max: Int
    
    @State private var value: Double = 0.0
    
    public init(max: Int) {
        self.max = max
    }
    
    public var body: some View {
        Button(action: {
            value += 0.1
        }, label: {
            VStack {
                Text("1/\(max)")
                    .font(.caption)
                    .bold()
                
                ProgressView(value: value)
            }
            .padding()
        })
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressBar(max: 10)
        }
        .previewLayout(.fixed(width: 320, height: 56))
    }
}
