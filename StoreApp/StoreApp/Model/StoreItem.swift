//
//  StoreItem.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 13..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

struct StoreItems {
    
    let storeItems: [StoreItem]
    
    var itemCount: Int {
        return storeItems.count
    }

    subscript(index: Int) -> StoreItem {
        return storeItems[index]
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
