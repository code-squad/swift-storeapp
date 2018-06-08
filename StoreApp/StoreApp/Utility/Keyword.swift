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
    case httpMethod
    case payLoadText
    case detailSectionView
    
    var name : String {
        switch self {
        case .fileType: return "json"
        case .headerCell: return "HeaderCell"
        case .listCell: return "ListCell"
        case .detailVC: return "detailVC"
        case .httpMethod: return "POST"
        case .payLoadText: return "text"
        case .detailSectionView: return "detailSectionView"
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
        case thumbnailData
        case detailSectionData
        case detailImagesCount
        case connection
        case reloadSections
        var name: String {
            switch self {
            case .reloadItems: return "reloadItems"
            case .sectionType: return "section"
            case .detailData: return "detailData"
            case .itemDetailTitle: return "itemDetailTitle"
            case .thumbnailData: return "thumbnailData"
            case .detailSectionData: return "detailSectionData"
            case .detailImagesCount: return "detailImagesCount"
            case .connection: return "connectionChanged"
            case .reloadSections: return "reloadSections"
            }
        }
    }
    
    enum ItemDetail {
        case base
        case order
        var URL: String {
            switch self {
            case .base: return "http://crong.codesquad.kr:8080/woowa/detail/"
            case .order: return "https://hooks.slack.com/services/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"
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
    
    enum toaster {
        case unreachable
        case connection
        var message: String {
            switch self {
            case .unreachable: return "인터넷 연결을 확인해 주세요."
            case .connection: return "인터넷이 정상적으로 연결되었습니다."
            }
        }
    }
    
    enum borderAnimation {
        case to
        case from
        case duration
        case keyPath
        case key
        var value: Any {
            switch self {
            case .to: return 0 as CGFloat
            case .from: return 7 as CGFloat
            case .duration: return 1.5
            case .keyPath: return "borderWidth"
            case .key: return "Width"
            }
        }
    }

}

extension Notification.Name {
    static let reloadItems = Notification.Name(Keyword.Observer.reloadItems.name)
    static let loadDetailData = Notification.Name(Keyword.Observer.detailData.name)
    static let thumbnail = Notification.Name(Keyword.Observer.thumbnailData.name)
    static let detailSection = Notification.Name(Keyword.Observer.detailSectionData.name)
    static let detailImagesCount = Notification.Name(Keyword.Observer.detailImagesCount.name)
    static let connection = Notification.Name(Keyword.Observer.connection.name)
    static let reloadSections = Notification.Name(Keyword.Observer.reloadSections.name)
}
