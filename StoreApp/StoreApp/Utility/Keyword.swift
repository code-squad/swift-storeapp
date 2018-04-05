//
//  Keyword.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

enum Keyword {
    case fileName
    case fileExtension
    case customCellName

    var value: String {
        switch self {
        case .fileName: return "main"
        case .fileExtension: return "json"
        case .customCellName: return "storeItem"
        }
    }
}
