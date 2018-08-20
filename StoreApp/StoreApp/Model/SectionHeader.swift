//
//  SectionHeader.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 15..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

struct SectionHeader {
    
    let title: String
    let subTitle: String
    let storeItems: StoreItems
    
    init(_ header: Header) {
        self.title = header.title
        self.subTitle = header.subTitle
        self.storeItems = StoreItems.init(url: header.url)
    }
    
    enum Header {
        case main
        case soup
        case side
        
        var url: String {
            switch self {
            case .main: return "http://crong.codesquad.kr:8080/woowa/main"
            case .soup: return "http://crong.codesquad.kr:8080/woowa/soup"
            case .side: return "http://crong.codesquad.kr:8080/woowa/side"
            }
        }
        
        var fileName: String {
            switch self {
            case .main: return "main"
            case .soup: return "soup"
            case .side: return "side"
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
    
}

struct Headers {
    
    private(set) var headers = [SectionHeader]()
    
    init() {
        self.headers = [SectionHeader(.main), SectionHeader(.soup), SectionHeader(.side)]
    }

}


