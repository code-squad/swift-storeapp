//
//  HTTP.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

enum HTTP {
    
    typealias Headers = [String: String]
    typealias Parameters = [String: Any]
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Task {
        
        case request
        case requestWithQueryParameters(Encodable)
        case requestWithBodyParameters(Encodable)
    }
    
    enum Status {
        case informationalResponse
        case success
        case redirection
        case clientError
        case serverError
        case unOfficial
    }
}
