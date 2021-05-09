//
//  XCTestCase+.swift
//  
//
//  Created by Shunya Yamada on 2021/05/09.
//

import XCTest
import Combine

// https://qiita.com/turara/items/f92d3a9a6904ada1b73a#%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%AA%E3%81%97%E3%81%A7%E3%83%86%E3%82%B9%E3%83%88%E3%81%99%E3%82%8B
extension XCTestCase {
    typealias CompetionResult = (expectation: XCTestExpectation, cancellable: AnyCancellable)
    
    func expectValue<T: Publisher>(
        of publisher: T,
        timeout: TimeInterval = 2,
        file: StaticString = #file,
        line: UInt = #line,
        equals: [T.Output]
    ) -> CompetionResult where T.Output: Equatable {
        let exp = expectation(description: "Correct values of " + String(describing: publisher))
        var mutableEquals = equals
        let cancellable = publisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    if value == mutableEquals.first {
                        mutableEquals.remove(at: 0)
                        if mutableEquals.isEmpty {
                            exp.fulfill()
                        }
                    }
            })
        return (exp, cancellable)
    }
}
