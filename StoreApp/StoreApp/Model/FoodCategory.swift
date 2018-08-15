//
//  FoodCategory.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

enum FoodCategory: String {
    case main
    case soup
    case side
    
    var title: String {
        switch self {
        case .main: return "메인반찬"
        case .soup: return "국∙찌게"
        case .side: return "밑반찬"
        }
    }
    
    var description: String {
        switch self {
        case .main: return "한그릇 뚝딱 메인 요리"
        case .soup: return "김이 모락모락 국.찌게"
        case .side: return "언제 먹어도 든든한 밑반찬"
        }
    }
}
