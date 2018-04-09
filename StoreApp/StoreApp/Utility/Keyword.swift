//
//  Keyword.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

enum Keyword {
    case mainFile
    case soupFile
    case sideFile
    case fileExtension
    case customCellName

    var value: String {
        switch self {
        case .mainFile: return "main"
        case .soupFile: return "soup"
        case .sideFile: return "side"
        case .fileExtension: return "json"
        case .customCellName: return "storeItem"
        }
    }

    var sectionName: String {
        switch self {
        case .mainFile: return "메인반찬 / 한그릇 뚝딱 메인 요리"
        case .soupFile: return "국.찌개 / 김이 모락모락 국.찌개"
        case .sideFile: return "밑반찬 / 언제 먹어도 든든한 밑반찬"
        default: return ""
        }
    }
}
