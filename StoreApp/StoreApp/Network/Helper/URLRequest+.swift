//
//  URLRequest+.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(_ url: URL, path: String, method: HTTP.Method, headers: HTTP.Headers) {
        self.init(url: url.appendingPathComponent(path))
        
        self.httpMethod = method.rawValue
        self.allHTTPHeaderFields = headers
    }
}
