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
        Text("\(entry.percent)")
            .font(.title)
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
    static var previews: some View {
        EntryView(entry: StoredResultEntry.empty)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
