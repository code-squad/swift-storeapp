//
//  Dummy.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

// MARK: - Dummy

enum DummyAPI {
    
    case main
    case soup
    case side
}

// MARK: - EndPoint

extension DummyAPI: EndPoint {
    
    var baseURL: URL {
        return URL(string: "http://public.codesquad.kr/jk/storeapp/")!
    }
    
    var method: HTTP.Method {
        return .get
    }
    
    var task: HTTP.Task {
        return .request
    }
    
    var headers: HTTP.Headers? {
        return nil
    }
    
    var sampleData: Data? {
        switch self {
        case .main:
            return NSDataAsset(name: "main")?.data
        case .soup:
            return NSDataAsset(name: "soup")?.data
        case .side:
            return NSDataAsset(name: "side")?.data
        }
    }
    
    func asURLRequest() -> URLRequest {
        return .init(url: baseURL)
    }
}
