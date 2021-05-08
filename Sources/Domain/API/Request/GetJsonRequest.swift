//
//  GetJsonRequest.swift
//  
//
//  Created by Shunya Yamada on 2021/05/07.
//

import Foundation
import Shared

public struct GetJsonRequest: APIRequest {
    public typealias Response = Quizzes
    
    public init() {}
    
    public var url: String {
        return "https://raw.githubusercontent.com/hayabusabusa/yrzy-hackathon-flutter/main/json/quiz.json"
    }
}
