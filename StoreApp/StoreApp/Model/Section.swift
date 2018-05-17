//
//  Section.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 12..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

struct Section {
    
    enum Header {
        case main
        case soup
        case side
        
        var type: String {
            switch self {
            case .main: return "main"
            case .soup: return "soup"
            case .side: return "side"
            }
        }
        
        var url: String {
            switch self {
            case .main: return "http://crong.codesquad.kr:8080/woowa/main"
            case .soup: return "http://crong.codesquad.kr:8080/woowa/soup"
            case .side: return "http://crong.codesquad.kr:8080/woowa/side"
            }
        }
        
        var title: String {
            switch self {
            case .main: return "메인반찬"
            case .soup: return "국.찌게"
            case .side: return "밑반찬"
            }
        }
        
        var subTitle: String {
            switch self {
            case .main: return "한그릇 뚝딱 메인 요리"
            case .soup: return "김이 모락모락 국.찌게"
            case .side: return "언제 먹어도 든든한 밑반찬"
            }
        }
    }

    let headerType: String
    let title: String
    let subTitle: String
    let storeItems: StoreItems

    init(_ sectionHeader : Header) {
        headerType = sectionHeader.type
        title = sectionHeader.title
        subTitle = sectionHeader.subTitle
        storeItems = StoreItems(sectionHeader)
    }
    
}
