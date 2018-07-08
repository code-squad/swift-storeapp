//
//  StoreItem.swift
//  StoreApp
//
//  Created by 백인철 on 2018. 7. 8..
//  Copyright © 2018년 Incheol. All rights reserved.
//

import Foundation

struct StoreItems {
    private var items: [StoreItem]
    init() {
        guard let mainJsonFilePath = Bundle.main.path(forResource: "main", ofType: "json") else {
            items = []
            return
        }
        do {
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: mainJsonFilePath))
            let json = try JSONDecoder().decode([StoreItem].self, from: data)
            self.items = json
        } catch {
            // error
            items = []
        }
    }
    
    subscript(index: Int) -> StoreItem {
        return self.items[index]
    }
    
    var count: Int {
        return self.items.count
    }
}

struct StoreItem: Decodable {
    var title: String?
    var description: String?
    var n_price: String?
    var s_price: String?
    var badge: [String]?
    var image: String?
    
    var badge1: String? {
        return badge?.first
    }
    var badge2: String? {
        guard let count = badge?.count else {
            return nil
        }
        if count > 1 {
            return badge?[1]
        }
        return nil
    }
}
