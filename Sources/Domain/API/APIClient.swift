//
//  APIClient.swift
//  
//
//  Created by Shunya Yamada on 2021/05/07.
//

import Foundation

public protocol APIClientProtocol {
    func call<T: APIRequest>(with request: T, completion: @escaping ((Result<T.Response, Error>) -> Void))
}

public final class APIClient: APIClientProtocol {
    
    public static let shared: APIClient = .init()
    
    private let session: URLSession
    
    private init() {
        session = URLSession.shared
    }
    
    public func call<T: APIRequest>(with request: T, completion: @escaping ((Result<T.Response, Error>) -> Void)) {
        guard let url = URL(string: request.url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        if let stub = request.stub {
            completion(.success(stub))
            return
        }
        
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
