//
//  StoreItem.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    let detailHash: String
    let imageURL: String
    let alt: String
    let deliveryType: [String]
    let title: String
    let description: String
    let normalPrice: String?
    let salePrice: String
    let badges: [String]?
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case imageURL = "image"
        case alt
        case deliveryType = "delivery_type"
        case title
        case description
        case normalPrice = "n_price"
        case salePrice = "s_price"
        case badges = "badge"
    }
}
