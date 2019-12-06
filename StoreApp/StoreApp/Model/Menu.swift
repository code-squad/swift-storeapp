//
//  Menu.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/05.
//  Copyright © 2019 이동영. All rights reserved.
//

import Foundation
import Then

// MARK: - Menu

struct Menu: Decodable {
    
    // MARK: - Properties
    
    let imageURL: String
    let deliveryType: [DeliveryType]
    let title: String
    let detail: String
    let price: String?
    let salePrice: String
    let badge: [String]?

    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image"
        case deliveryType = "delivery_type"
        case title
        case detail = "description"
        case price = "n_price"
        case salePrice = "s_price"
        case badge
    }
}

// MARK: - Then

extension Menu: Then {}

// MARK: - DeliveryType

enum DeliveryType: String, Decodable {
    
    case dawnShipping = "새벽배송"
    case nationalShipping = "전국택배"
}

