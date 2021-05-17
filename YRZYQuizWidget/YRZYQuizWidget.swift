//
//  YRZYQuizWidget.swift
//  YRZYQuizWidget
//
//  Created by Shunya Yamada on 2021/05/17.
//

import WidgetKit
import SwiftUI

// NOTE: Widget がいつ更新すればいいかの情報を提供する.
struct Provider: TimelineProvider {
    
    // NOTE: Widget の初期表示のデータを決めるメソッド.
    // Widget 初回起動時に呼び出される.
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    // NOTE: ホーム画面に Widget が追加されたときや、ユーザーが Widget を選択する Widget Gallery で View を表示するためのデータを作成するメソッド.
    // `completion` でデータを渡せるので非同期も可能.
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    // NOTE: WidgetKit にタイムラインを伝えるメソッド.
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        // NOTE: `Timeline` は Widget の View をどのように更新するか決める型.
        // `policy` には View をいつ更新させるかを指定する.
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// NOTE: `Date` のプロパティを必須とするプロトコル.
struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct YRZYQuizWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct YRZYQuizWidget: Widget {
    let kind: String = "YRZYQuizWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            YRZYQuizWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("クイズの結果")
        .description("今まで答えたクイズの累計の結果を確認することができます。")
    }
}

struct YRZYQuizWidget_Previews: PreviewProvider {
    static var previews: some View {
        YRZYQuizWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
