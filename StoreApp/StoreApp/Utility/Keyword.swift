//
//  Keyword.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 25..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

enum Keyword {
    
    case file
    case fileType
    case customCell
    case soup
    case side
    
    var name : String {
        switch self {
        case .file : return "main"
        case .fileType: return "json"
        case .customCell: return "ListCell"
        case .soup: return "soup"
        case .side: return "side"
        }
    }
    
}
