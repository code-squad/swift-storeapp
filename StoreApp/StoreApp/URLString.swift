//
//  URL.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/6/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import Foundation

enum URLString: String {
    case main = "http://public.codesquad.kr/jk/storeapp/main.json"
    case soup = "http://public.codesquad.kr/jk/storeapp/soup.json"
    case side = "http://public.codesquad.kr/jk/storeapp/side.json"
    
    init(call: Int) {
        switch call {
        case 0 : self = .main
        case 1 : self = .soup
        default: self = .side
        }
    }
    
    func getHeaderTitle() -> String {
        switch self {
        case .main: return "메인반찬"
        case .soup: return "국.찌게"
        case .side: return "밑반찬"
        }
    }
    
    func getHeaderDescription() -> String {
        switch self {
        case .main: return "한그릇 뚝딱 메인 요리"
        case .soup: return "김이 모락모락 국.찌게"
        case .side: return "언제 먹어도 든든한 밑반찬"
        }
    }
}
