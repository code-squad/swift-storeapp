//
//  Server.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 26..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

@objc protocol ServerAPI {
    var main: String { get }
    var soup: String { get }
    var side: String { get }
    @objc optional var detail: String { get }
    @objc optional var slackHook: String { get }
}

enum Server {
    case local
    case remote

    var api: ServerAPI {
        switch self {
        case .local: return Local.init()
        case .remote: return Remote.init()
        }
    }
}

class Local: ServerAPI {
    let main: String  = "http://localhost:3000/main"
    let soup: String = "http://localhost:3000/soup"
    let side: String = "http://localhost:3000/side"
}

class Remote: ServerAPI {
    let main: String = "http://crong.codesquad.kr:8080/woowa/main"
    let soup: String = "http://crong.codesquad.kr:8080/woowa/soup"
    let side: String = "http://crong.codesquad.kr:8080/woowa/side"
    let detail: String = "http://crong.codesquad.kr:8080/woowa/detail/"
    let slackHook: String = "https://hooks.slack.com/services/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"
}
