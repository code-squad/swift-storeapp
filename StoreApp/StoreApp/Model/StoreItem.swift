//
//  StoreItem.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    var detailHash: String
    var image: String
    var alt: String
    var deliveryType: [String]
    var title: String
    var description: String
    var nPrice: String
    var sPrice: String
    var badge: [String]

    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case deliveryType = "delivery_type"
        case nPrice = "n_price"
        case sPrice = "s_price"
        case image, alt, title, description, badge
    }
}
