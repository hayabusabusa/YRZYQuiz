//
//  ProgressBar.swift
//  
//
//  Created by Shunya Yamada on 2021/05/07.
//

import SwiftUI

public struct ProgressBar: View {
    @Binding var value: Int
    let max: Int
    
    @State private var doubleValue: Double = 0
    
    public init(value: Binding<Int>, max: Int) {
        self._value = value
        self.max = max
        self._doubleValue = State(initialValue: Double(self.value) / Double(max))
    }
    
    public var body: some View {
        VStack(spacing: 4.0) {
            HStack(spacing: 4.0) {
                Text(String(value))
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color(.systemGray))
                
                Text("/ \(max)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(Color(.systemGray))
            }
            ProgressView(value: doubleValue)
        }
        .padding()
        .onChange(of: value, perform: { newValue in
            doubleValue = Double(newValue) / Double(max)
        })
    }
}

struct ProgressBar_Previews: PreviewProvider {
    @State static var value: Int = 4
    
    static var previews: some View {
        Group {
            ProgressBar(value: $value, max: 10)
        }
        .previewLayout(.fixed(width: 320, height: 56))
    }
}
