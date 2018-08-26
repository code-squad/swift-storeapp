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
}
