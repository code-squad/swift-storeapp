//
//  StoreItem.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    let detail_hash: String
    let image: String
    let alt: String
    let delivery_type: String
    let title: String
    let description: String
    let n_price: String?
    let s_price: String
    let badge: [String]?
}
