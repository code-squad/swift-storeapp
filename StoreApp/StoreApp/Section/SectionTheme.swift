//
//  SectionTheme.swift
//  StoreApp
//
//  Created by 윤동민 on 15/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

enum SectionTheme: Int, CaseIterable {
    case main = 0
    case soup = 1
    case side = 2
    
    func getTheme() -> String {
        switch self {
        case .main: return "메인반찬"
        case .soup: return "국.찌게"
        case .side: return "밑반찬"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .main: return "한그릇 뚝딱 메인 요리"
        case .soup: return "김이 모락모락 국.찌게"
        case .side: return "언제 먹어도 든든한 밑반찬"
        }
    }
}
