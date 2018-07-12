//
//  StoreItems.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 9..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

let CATEGORIES: [Category] = [.main, .soup, .side]

struct StoreItems {
    let storeItem:  [Category: Items]

    init() {
        self.storeItem = ItemDataParser.makeStoreItems()
    }

    subscript(index: Int) -> Items {
        get {
            return storeItem[CATEGORIES[index]]!
        }
    }
}

struct Items {
    let items: [ItemData]

    init(data: [ItemData]) {
        self.items = data
    }

    subscript(index: Int) -> ItemData {
        get {
            return items[index]
        }
    }

    func count() -> Int {
        return self.items.count
    }

}

struct ItemData: Codable {
    var detail_hash: String
    var image: String
    var alt: String
    var delivery_type: [String]
    var title: String
    var description: String
    var n_price: String?
    var s_price: String
    var badge: [String]?
}

