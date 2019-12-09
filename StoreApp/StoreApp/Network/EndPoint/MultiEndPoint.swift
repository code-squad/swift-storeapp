//
//  MultiEndPoint.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/10.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation


// MARK: - MultiEndPoint

enum MultiEndPoint {
    
    case endPoint(EndPoint)
    
    var endPoint: EndPoint {
        switch self {
        case .endPoint(let endPoint):
            return endPoint
        }
    }
}

// MARK: - EndPoint

extension MultiEndPoint: EndPoint {
    
    var baseURL: URL {
        return endPoint.baseURL
    }
    
    var method: HTTP.Method {
        return endPoint.method
    }
    
    var task: HTTP.Task {
        return endPoint.task
    }
    
    var headers: HTTP.Headers? {
        endPoint.headers
    }
    
    func asURLRequest() -> URLRequest {
        return endPoint.asURLRequest()
    }
    
    var sampleData: Data? {
        return endPoint.sampleData
    }
}
