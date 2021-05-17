//
//  StoredResultEntry.swift
//  YRZYQuizWidget
//
//  Created by Shunya Yamada on 2021/05/17.
//

import WidgetKit

public struct StoredResultEntry: TimelineEntry {
    public let date: Date
    public let percent: Int
    public let numberOfAnswered: Int
    public let numberOfCorrect: Int
    
    public init(date: Date, percent: Int, numberOfAnswered: Int, numberOfCorrect: Int) {
        self.date = date
        self.percent = percent
        self.numberOfAnswered = numberOfAnswered
        self.numberOfCorrect = numberOfCorrect
    }
}
