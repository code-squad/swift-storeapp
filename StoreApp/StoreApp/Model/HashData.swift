//
//  HashData.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 27..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct HashData: Decodable {
    let hash: String
    let data: DetailItem
    
    enum CodingKeys: String, CodingKey {
        case hash
        case data
    }
}

struct DetailItem: Decodable {
    let topImageURL: String
    let thumbnailImageURLs: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSectionURLs: [String]
    
    enum CodingKeys: String, CodingKey {
        case topImageURL = "top_image"
        case thumbnailImageURLs = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSectionURLs = "detail_section"
    }
}
