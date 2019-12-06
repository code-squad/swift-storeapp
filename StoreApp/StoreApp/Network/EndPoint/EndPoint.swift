//
//  EndPoint.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/05.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation

protocol EndPoint: URLRequestConvertible {
    
    var baseURL: URL { get }
    var method: HTTP.Method { get }
    var task: HTTP.Task { get }
    var headers: HTTP.Headers? { get }
}
