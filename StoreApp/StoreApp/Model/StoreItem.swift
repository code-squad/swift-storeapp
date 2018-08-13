//
//  StoreItem.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 13..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

class StoreItems {
    
    private var storeItems = [StoreItem]()
    
    let decoder = JSONDecoder()
    
    var itemCount: Int {
        return storeItems.count
    }

    subscript(index: Int) -> StoreItem {
        return storeItems[index]
    }
    
    func extractJSONData() {
        guard let path = Bundle.main.path(forResource: "main", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return }
        self.storeItems = jsonDecode(data)
    }
    
    func jsonDecode(_ data: Data) -> [StoreItem] {
        do {
            return try decoder.decode([StoreItem].self, from: data)
        } catch  {
            return []
        }
    }
    
}

struct StoreItem: Decodable {
    let detail_hash: String
    let image: String
    let alt: String
    let delivery_type: [String]
    let title: String
    let description: String
    let n_price: String?
    let s_price: String
    let badge: [String]?
}
