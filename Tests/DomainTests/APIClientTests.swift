//
//  APIClientTests.swift
//  
//
//  Created by Shunya Yamada on 2021/05/08.
//

import XCTest
import Shared
@testable import Domain

final class APIClientTests: XCTestCase {
    
    func test_無効なURLの場合はエラーを返すことを確認() {
        let request = MockAPIRequest(targetURL: "")
        let expectation = XCTestExpectation(description: "Wait for mock API response")
        
        var apiError: APIError?
        
        APIClient.shared.call(with: request) { result in
            defer {
                expectation.fulfill()
            }
            
            switch result {
            case .success:
                fatalError()
            case .failure(let error):
                apiError = error as? APIError
            }
        }
        
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(apiError)
    }
    
    func test_Stubの指定がある場合はStubを利用することを確認() {
        let request = MockAPIRequest(targetURL: "https://example.com")
        let expectation = XCTestExpectation(description: "Wait for mock API response")
        
        var response: Quiz?
        
        APIClient.shared.call(with: request) { result in
            defer {
                expectation.fulfill()
            }
            
            switch result {
            case .success(let value):
                response = value
            case .failure:
                fatalError()
            }
        }
        
        XCTWaiter().wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(response?.question, "TEST")
    }
}
