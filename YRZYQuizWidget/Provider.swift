//
//  Provider.swift
//  YRZYQuizWidget
//
//  Created by Shunya Yamada on 2021/05/17.
//

import Domain
import Shared
import WidgetKit

// NOTE: Widget がいつ更新すればいいかの情報を提供する.
struct Provider: TimelineProvider {
    typealias Entry = StoredResultEntry
    
    // NOTE: Widget の初期表示のデータを決めるメソッド.
    // Widget 初回起動時に呼び出される.
    func placeholder(in context: Context) -> StoredResultEntry {
        return StoredResultEntry(date: Date(), percent: 80, numberOfAnswered: 10, numberOfCorrect: 8)
    }

    // NOTE: ホーム画面に Widget が追加されたときや、ユーザーが Widget を選択する Widget Gallery で View を表示するためのデータを作成するメソッド.
    // `completion` でデータを渡せるので非同期も可能.
    func getSnapshot(in context: Context, completion: @escaping (StoredResultEntry) -> ()) {
        // NOTE: Widget Gallary 内ではダミーのデータ等を渡す.
        if context.isPreview {
            completion(StoredResultEntry.empty)
            return
        }
        
        completion(load())
    }

    // NOTE: WidgetKit にタイムラインを伝えるメソッド.
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries = [load()]
        
        // NOTE: `Timeline` は Widget の View をどのように更新するか決める型.
        // `policy` には View をいつ更新させるかを指定する.
        // アプリ側からリロードをかけるとここが再度実行される.
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

extension Provider {
    
    private func load() -> StoredResultEntry {
        if let stored = UserDefaultsProvider.shared.value(StoredResult.self, forKey: .result) {
            return StoredResultEntry(date: Date(), percent: stored.percent, numberOfAnswered: stored.numberOfAnswered, numberOfCorrect: stored.numberOfCorrect)
        } else {
            // NOTE: 読み込めなかったときは空のデータを表示する.
            return StoredResultEntry.empty
        }
    }
}
