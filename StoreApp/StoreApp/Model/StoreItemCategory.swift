//
//  StoreItemCategory.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/16.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

enum StoreItemCategory: String, CaseIterable {
    case main
    case soup
    case side
    
    var titleText: String {
        switch self {
        case .main: return "메인반찬"
        case .soup: return "국.찌개"
        case .side: return "밑반찬"
        }
    }
    
    var descriptionText: String {
        switch self {
        case .main: return "한 그릇 뚝딱 메인 요리"
        case .soup: return "김이 모락모락 국.찌개"
        case .side: return "언제 먹어도 든든한 밑반찬"
        }
    }
}
