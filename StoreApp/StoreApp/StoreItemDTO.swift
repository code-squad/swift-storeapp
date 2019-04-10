//
//  StoreItemDTO.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct StoreItemDTO {
    let detail_hash: String
    let image: String
    let alt: String
    let delivery_type: [String]
    let title: String
    let description: String
    let n_price: String?
    let s_price: String
    let badge: [String]?
    
    init(detail_hash: String, image: String, alt: String,
         delivery_type: [String], title: String, description: String,
         n_price: String?, s_price: String, badge: [String]?) {
        self.detail_hash = detail_hash
        self.image = image
        self.alt = alt
        self.delivery_type = delivery_type
        self.title = title
        self.description = description
        self.n_price = n_price
        self.s_price = s_price
        self.badge = badge
    }
}
