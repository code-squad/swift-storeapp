//
//  Section.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

struct Section {
    let title: String
    let subtitle: String
    let cell: [StoreItem]

    init(title: String, subtitle: String, cell: [StoreItem]) {
        self.title = title
        self.subtitle = subtitle
        self.cell = cell
    }

    init(section: TableSection, items: [StoreItem]) {
        self.init(title: section.title, subtitle: section.subtitle, cell: items)
    }
}

enum TableSection: Int {
    case main = 0
    case soup
    case side

    var title: String {
        switch self {
        case .main: return "메인반찬"
        case .soup: return "국.찌게"
        case .side: return "밑반찬"
        }
    }

    var subtitle: String {
        switch self {
        case .main: return "한그릇 뚝딱 메인 요리"
        case .soup: return "김이 모락모락 국.찌게"
        case .side: return "언제 먹어도 든든한 밑반찬"
        }
    }
}
