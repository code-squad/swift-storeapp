//
//  Dummy.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/06.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

// MARK: - DummyMain

enum DummyMain {
    
    case endPoint
}

extension DummyMain: EndPoint {
    
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
    
    var sampleData: Data? {
        return NSDataAsset(name: "side")!.data
    }
}

// MARK: - DummySoup

enum DummySoup {
    
    case endPoint
}

extension DummySoup: EndPoint {
    
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
    
    var sampleData: Data? {
        return NSDataAsset(name: "side")!.data
    }
}

// MARK: - DummySide

enum DummySide {
    
    case endPoint
}

extension DummySide: EndPoint {
    
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
    
    var sampleData: Data? {
        return NSDataAsset(name: "side")!.data
    }
}
