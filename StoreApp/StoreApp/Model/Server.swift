//
//  Server.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 26..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

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

protocol ServerAPI {
    var main: String { get }
    var soup: String { get }
    var side: String { get }
}

class Local: ServerAPI {
    var main: String {
        return "http://localhost:3000/main"
    }

    var soup: String {
        return "http://localhost:3000/soup"
    }

    var side: String {
        return "http://localhost:3000/side"
    }
}

class Remote: ServerAPI {
    var main: String {
        return "http://crong.codesquad.kr:8080/woowa/main"
    }

    var soup: String {
        return "http://crong.codesquad.kr:8080/woowa/soup"
    }

    var side: String {
        return "http://crong.codesquad.kr:8080/woowa/side"
    }
}
