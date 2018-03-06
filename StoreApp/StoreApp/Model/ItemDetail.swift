//
//  ItemDetail.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 28..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

struct ItemDetail: Decodable {
    let hash: String
    let data: DetailData

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.hash = try values.decode(String.self, forKey: .hash)
        self.data = try values.decode(DetailData.self, forKey: .data)
    }

    enum CodingKeys: String, CodingKey {
        case hash
        case data
    }
}

struct DetailData: Decodable {
    let topImage: String
    let thumbImages: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSection: [String]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.topImage = try values.decode(String.self, forKey: .topImage)
        self.thumbImages = try values.decode([String].self, forKey: .thumbImages)
        self.productDescription = try values.decode(String.self, forKey: .productDescription)
        self.point = try values.decode(String.self, forKey: .point)
        self.deliveryInfo = try values.decode(String.self, forKey: .deliveryInfo)
        self.deliveryFee = try values.decode(String.self, forKey: .deliveryFee)
        self.prices = try values.decode([String].self, forKey: .prices)
        self.detailSection = try values.decode([String].self, forKey: .detailSection)
    }

    enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSection = "detail_section"
    }
}
