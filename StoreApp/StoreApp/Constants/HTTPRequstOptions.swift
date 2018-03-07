//
//  HTTPRequstOptions.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

struct OrderMessage {
    static func slack(_ orderInfo: OrderInfo) -> String {
        return "- 주문자: \(orderInfo.name),\n - 가격: \(orderInfo.price),\n - 메뉴: \(orderInfo.menu)"
    }
}

enum SlackBody {
    case username(String)
    case text(String)
    case iconUrl(String)
    case channel(String)
    var payload: [String: String]? {
        switch self {
        case .text(let value): return ["text": value]
        default: return nil
        }
    }
}

enum HTTPMethod: CustomStringConvertible {
    case get
    case post

    var description: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

enum HTTPHeaderField: CustomStringConvertible {
    case contentType
    case accept

    var description: String {
        switch self {
        case .contentType: return "Content-Type"
        case .accept: return "Accept"
        }
    }
}

enum HTTPContentType {
    enum Application: CustomStringConvertible {
        case json
        case urlencode
        var description: String {
            let prefix = "application/"
            switch self {
            case .json: return prefix + "json"
            case .urlencode: return prefix + "x-www-form-urlencode"
            }
        }
    }
    enum Text: String, CustomStringConvertible {
        case css
        case javascript
        case html
        case plain
        var description: String {
            let prefix = "text/"
            return prefix + self.rawValue
        }
    }
    enum File: CustomStringConvertible {
        case formedData
        var description: String {
            let prefix = "multipart/"
            switch self {
            case .formedData: return prefix + "formed-data"
            }
        }
    }
}
