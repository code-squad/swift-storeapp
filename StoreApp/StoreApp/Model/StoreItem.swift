//
//  StoreItem.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    let detailHash: String
    let thumbnailUrl: String
    let alt: String
    let deliveryTypes: [String]
    let title: String
    let description: String
    let salePrice: String
    let normalPrice: String?
    let badges: [String]?
    let thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image
        case alt
        case deliveryTypes = "delivery_type"
        case title
        case description
        case salePrice = "s_price"
        case normalPrice = "n_price"
        case badges = "badge"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.detailHash = try values.decode(String.self, forKey: .detailHash)
        self.thumbnailUrl = try values.decode(String.self, forKey: .image)
        self.alt = try values.decode(String.self, forKey: .alt)
        self.deliveryTypes = try values.decode([String].self, forKey: .deliveryTypes)
        self.title = try values.decode(String.self, forKey: .title)
        self.description = try values.decode(String.self, forKey: .description)
        self.salePrice = try values.decode(String.self, forKey: .salePrice)
        self.normalPrice = try? values.decode(String.self, forKey: .normalPrice)
        self.badges = try? values.decode([String].self, forKey: .badges)
        self.thumbnail = try Thumbnail(urlString: thumbnailUrl)
    }

}
