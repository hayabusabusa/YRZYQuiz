//
//  HomeScreen.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import SwiftUI

public struct HomeScreen: View {
    @State private var isShowQuizScreen = false
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            // MARK: Texts VStack
            VStack(alignment: .center) {
                Text("yrozuya presents")
                    .foregroundColor(.blue)
                    .font(.callout)
                
                Text("クイズアプリ")
                    .foregroundColor(.blue)
                    .font(.title)
                    .bold()
                
                Spacer()
                    .frame(height: 8)
                
                Text("簡単な問題ばかりなので\n100点目指して頑張りましょう！")
                    .multilineTextAlignment(.center)
                    
            }
            
            // MARK: Flexible Spacer
            Spacer()
            
            // MARK: Buttons VStack
            VStack {
                Button(action: {
                    isShowQuizScreen = true
                }, label: {
                    HStack {
                        Spacer()
                        Text("クイズを始める")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(4.0)
                })
            }
        }
        .padding(.all, 24)
        .fullScreenCover(isPresented: $isShowQuizScreen, content: {
            QuizScreen()
        })
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
