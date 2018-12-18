//
//  StoreItem.swift
//  StoreApp
//
//  Created by oingbong on 06/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    var detailHash: String
    var image: String
    var alt: String
    var deliveryType: [String]
    var title: String
    var description: String
    var nPrice: String?
    var sPrice: String
    var badge: [String]?
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image = "image"
        case alt = "alt"
        case deliveryType = "delivery_type"
        case title = "title"
        case description = "description"
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge = "badge"
    }
}
