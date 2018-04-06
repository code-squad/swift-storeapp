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
}
