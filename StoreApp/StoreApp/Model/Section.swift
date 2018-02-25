//
//  Section.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Section {
    let type: TableSection
    let cell: [StoreItem]

    init() {
        self.type = .main
        self.cell = []
    }

    init(type: TableSection, cell: [StoreItem]) {
        self.type = type
        self.cell = cell
    }
}

enum TableSection: Int {
    case main = 0
    case soup
    case side

    static var cases: [TableSection] {
        return [TableSection.main, .soup, .side]
    }

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

    func api(from serverType: Server) -> String {
        let serverType = serverType.api
        switch self {
        case .main: return serverType.main
        case .soup: return serverType.soup
        case .side: return serverType.side
        }
    }

    var localFilename: String {
        switch self {
        case .main: return "main"
        case .soup: return "soup"
        case .side: return "side"
        }
    }
}
