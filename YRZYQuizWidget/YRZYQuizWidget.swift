//
//  YRZYQuizWidget.swift
//  YRZYQuizWidget
//
//  Created by Shunya Yamada on 2021/05/17.
//

import SwiftUI
import WidgetKit

struct EntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            // MARK: Percent VStack
            VStack(spacing: 0) {
                Spacer()
                Text("現在の正解率")
                    .font(.caption2)
                Text("\(entry.percent)%")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(.green)
                Spacer()
            }
            
            // MARK: Numbers HStack
            HStack(alignment: .lastTextBaseline, spacing: 2.0) {
                Spacer()
                Text("\(entry.numberOfCorrect)")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                Text("/")
                    .font(.caption)
                Text("\(entry.numberOfAnswered)")
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .foregroundColor(.gray)
        }
        .padding(.all, 16)
    }
}

@main
struct YRZYQuizWidget: Widget {
    let kind: String = "YRZYQuizWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EntryView(entry: entry)
        }
        .configurationDisplayName("クイズの結果")
        .description("今まで答えたクイズの累計の結果を確認することができます。")
        .supportedFamilies([.systemSmall])
    }
}

struct YRZYQuizWidget_Previews: PreviewProvider {
    static let entry = StoredResultEntry(date: Date(), percent: 100, numberOfAnswered: 100, numberOfCorrect: 100)
    
    static var previews: some View {
        Group {
            EntryView(entry: entry)
        }
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
