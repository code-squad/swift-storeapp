//
//  Keyword.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 25..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation
import UIKit

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
        case detailData
        case itemDetailTitle
        var name: String {
            switch self {
            case .reloadItems: return "reloadItems"
            case .sectionType: return "section"
            case .detailData: return "detailData"
            case .itemDetailTitle: return "itemDetailTitle"
            }
        }
    }
    
    enum ItemDetail {
        case base
        var URL: String {
            switch self {
            case .base: return "http://crong.codesquad.kr:8080/woowa/detail/"
            }
        }
    }
    
    enum viewFloat {
        case zero
        case detailSectionHeight
        var value: CGFloat {
            switch self {
            case .zero: return 0
            case .detailSectionHeight: return 400
            }
        }
    }
}

extension Notification.Name {
    static let reloadItems = Notification.Name(Keyword.Observer.reloadItems.name)
    static let loadDetailData = Notification.Name(Keyword.Observer.detailData.name)
}
