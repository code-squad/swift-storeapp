//
//  Section.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class Section: NSObject {
    let type: TableSection
    let cells: [StoreItem]

    override init() {
        self.type = .main
        self.cells = []
        super.init()
    }

    init(type: TableSection, cell: [StoreItem]) {
        self.type = type
        self.cells = cell
    }
}
