//
//  StoreItem.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/6/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import Foundation

struct StoreItem: Codable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [DeliveryType]
    let title, storeItemDescription: String
    let nPrice: String?
    let sPrice: String
    let badge: [String]?
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image, alt
        case deliveryType = "delivery_type"
        case title
        case storeItemDescription = "description"
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge
    }
}

enum DeliveryType: String, Codable {
    case 새벽배송 = "새벽배송"
    case 전국택배 = "전국택배"
}

typealias StoreItems = [StoreItem]
