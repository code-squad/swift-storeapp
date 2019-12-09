//
//  Category.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/10.
//  Copyright © 2019 이동영. All rights reserved.
//
import Foundation
import Then

// MARK: - Category

enum Category: String {
    case main = "메인반찬"
    case soup = "국.찌게"
    case side = "밑반찬"
}

// MARK: - CustomStringConvertible

extension Category: CustomStringConvertible {
    var description: String {
        switch self {
        case .main:
            return "한그릇 뚝딱 메인 요리"
        case .soup:
            return "김이 모락모락 국.찌게"
        case .side:
            return "언제 먹어도 든든한 밑반찬"
        }
    }
}

// MARK: - Then

extension Category: Then {}
