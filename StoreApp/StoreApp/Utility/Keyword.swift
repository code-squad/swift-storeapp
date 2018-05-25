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
    case detailVC
    
    var name : String {
        switch self {
        case .fileType: return "json"
        case .headerCell: return "HeaderCell"
        case .listCell: return "ListCell"
        case .detailVC: return "detailVC"
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
    
    enum Observer {
        case reloadItems
        case sectionType
        var name: String {
            switch self {
            case .reloadItems: return "reloadItems"
            case .sectionType: return "section"
            }
        }
    }
}

extension Notification.Name {
    static let reloadItems = Notification.Name(Keyword.Observer.reloadItems.name)
}
