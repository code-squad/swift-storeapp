//
//  Dummy.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

enum Dummy {
    static let storeData = NSDataAsset(name: "main")!.data
    
    case endPoint
}

extension Dummy: EndPoint {
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var method: HTTP.Method {
        return .post
    }
    
    var task: HTTP.Task {
        return .request
    }
    
    var headers: HTTP.Headers? {
        return [:]
    }
    
    func asURLRequest() -> URLRequest {
        return URLRequest(url: baseURL)
    }
}
