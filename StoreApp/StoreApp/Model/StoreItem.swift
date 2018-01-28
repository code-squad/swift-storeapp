//
//  StoreItem.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 27..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

struct StoreItem: Decodable {
    var detail_hash: String
    var image: URL
    var alt: String
    var delivery_type: [String]
    var title: String
    var description: String
    var n_price: Int?
    var s_price: Int
    var badge: [String]?

    enum CodingKeys: String, CodingKey {
        case detail_hash, image, alt, delivery_type, title, description, n_price, s_price, badge
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        detail_hash = try container.decode(String.self, forKey: .detail_hash)
        image = try container.decode(URL.self, forKey: .image)
        alt = try container.decode(String.self, forKey: .alt)
        delivery_type = try container.decode([String].self, forKey: .delivery_type)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        let n_price_string = try? container.decode(String.self, forKey: .n_price)
        let s_price_string = try container.decode(String.self, forKey: .s_price)
        n_price = n_price_string?.number
        s_price = s_price_string.number
        badge = try? container.decode([String].self, forKey: .badge)
    }
}
