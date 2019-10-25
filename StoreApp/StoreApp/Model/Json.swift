//
//  json.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit

struct Foods: Codable {
    let statusCode: Int
    let body: [StoreItem]
    
    struct StoreItem: Codable {
        let detailHash: String
        let image: String
        let alt: String
        var deliveryType: [String] = []
        let title: String
        let description: String
        let nPrice: String?
        let sPrice: String
        var badge: [String]? = []
        
        private enum CodingKeys: String, CodingKey {
            case detailHash = "detail_hash"
            case image
            case alt
            case deliveryType = "delivery_type"
            case title
            case description
            case nPrice = "n_price"
            case sPrice = "s_price"
            case badge
        }
    }
    subscript (index: Int) -> StoreItem {
        return body[index]
    }
}


