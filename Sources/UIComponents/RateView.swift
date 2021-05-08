//
//  RateView.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import SwiftUI

public struct RateView: View {
    private let rate: Int
    private let max: Int
    
    public init(rate: Int, max: Int = 5) {
        self.rate = rate
        self.max = max
    }
    
    public var body: some View {
        HStack {
            ForEach(0 ..< max) { num in
                if num < rate {
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.gray.opacity(0.6))
                }
            }
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RateView(rate: 4)
            RateView(rate: 4)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 320, height: 56))
    }
}
