//
//  DetailItem.swift
//  StoreApp
//
//  Created by oingbong on 20/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct DetailItem: Decodable {
    var topImage: String
    var thumbImages: [String]
    var productDescription: String
    var point: String
    var deliveryInfo: String
    var deliveryFee: String
    var prices: [String]
    var detailSection: [String]
    
    enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point = "point"
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices = "prices"
        case detailSection = "detail_section"
    }
}
