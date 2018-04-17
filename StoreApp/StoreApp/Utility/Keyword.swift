//
//  Keyword.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

struct Keyword {
    enum Section {
        case main
        case soup
        case side

        var value: String {
            switch self {
            case .main: return "main"
            case .soup: return "soup"
            case .side: return "side"
            }
        }

        var description: String {
            switch self {
            case .main: return "메인반찬 / 한그릇 뚝딱 메인 요리"
            case .soup: return "국.찌개 / 김이 모락모락 국.찌개"
            case .side: return "밑반찬 / 언제 먹어도 든든한 밑반찬"
            }
        }

        var url: String {
            switch self {
            case .main: return "http://crong.codesquad.kr:8080/woowa/main"
            case .soup: return "http://crong.codesquad.kr:8080/woowa/soup"
            case .side: return "http://crong.codesquad.kr:8080/woowa/side"
            }
        }
    }

    enum CellIdentifier {
        case storeItem
        case header

        var value: String {
            switch self {
            case .storeItem: return "storeItem"
            case .header: return "header"
            }
        }
    }

    enum Size {
        case header
        var value: Int {
            switch self {
            case .header: return 60
            }
        }
    }
}
