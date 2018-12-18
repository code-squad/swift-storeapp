//
//  Topic.swift
//  StoreApp
//
//  Created by oingbong on 11/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

enum Topic: Int, CaseIterable {
    case main = 0
    case soup
    case side

    var englihsName: String {
        switch self {
        case .main: return "main"
        case .soup: return "soup"
        case .side: return "side"
        }
    }

    var koreanName: String {
        switch self {
        case .main: return "메인반찬"
        case .soup: return "국.찌게"
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
