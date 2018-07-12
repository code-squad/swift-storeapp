//
//  Category.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

enum Category: String {
    case main
    case soup
    case side

    var description: (short: String, long: String) {
        switch self {
        case .main:
            return (short: "메인반찬", long: "한그릇 뚝딱 메인 요리")
        case .side:
            return (short: "국.찌개", long: "김이 모락모락 국.찌개")
        case .soup:
            return (short: "밑반찬", long: "언제 먹어도 든든한 밑반찬")
        }
    }
}
