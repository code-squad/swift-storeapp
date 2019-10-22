//
//  Models.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/21.
//  Copyright © 2019 hong3. All rights reserved.
//

import Foundation

//MARK: - StoreItem
struct StoreItem:Decodable {
    let detailHash: String?
    let StoreImage: String?
    let alt: String?
    let deliveryType: [String]?
    let title, Description, nPrice, sPrice: String?
    let badge: [String]?
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case StoreImage = "image"
        case alt
        case deliveryType = "delivery_type"
        case title
        case Description = "description"
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge
    }
}

let jsonDecoder = JSONDecoder()


