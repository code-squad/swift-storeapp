//
//  Keyword.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 25..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

enum Keyword {
    
    case fileType
    case headerCell
    case listCell
    
    var name : String {
        switch self {
        case .fileType: return "json"
        case .headerCell: return "HeaderCell"
        case .listCell: return "ListCell"
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
