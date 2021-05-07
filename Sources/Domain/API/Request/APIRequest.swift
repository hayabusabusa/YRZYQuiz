//
//  APIRequest.swift
//  
//
//  Created by Shunya Yamada on 2021/05/07.
//

import Foundation

public protocol APIRequest {
    associatedtype Response: Decodable
    
    var url: String { get }
    var stub: Response? { get }
}

extension APIRequest {
    
    public var stub: Response? {
        return nil
    }
}
