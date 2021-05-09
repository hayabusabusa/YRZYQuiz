//
//  MockAPIClient.swift
//  
//
//  Created by Shunya Yamada on 2021/05/09.
//

import Foundation
import Domain

enum MockAPIError: Error {
    case stubNotFound
}

final class MockAPIClicent: APIClientProtocol {
    
    func call<T>(with request: T, completion: @escaping ((Result<T.Response, Error>) -> Void)) where T : APIRequest {
        guard let stub = request.stub else {
            completion(.failure(MockAPIError.stubNotFound))
            return
        }
        completion(.success(stub))
    }
}
