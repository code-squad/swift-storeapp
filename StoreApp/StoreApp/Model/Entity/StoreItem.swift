//
//  StoreItem.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

struct StoreItem: Codable {
    let detailHash: String
    let image: String
    let title: String
    let description: String
    let originalPrice: String?
    let discountedPrice: String?
    let deliveryTypes: [String]
    let badges: [String]?
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image
        case title
        case description
        case originalPrice = "n_price"
        case discountedPrice = "s_price"
        case deliveryTypes = "delivery_type"
        case badges = "badge"
    }
}
