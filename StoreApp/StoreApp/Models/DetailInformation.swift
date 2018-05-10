//
//  DetailInformation.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 25..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

struct Detail: Decodable {
    let hash: String
    let data: DetailInformation
}

struct DetailInformation: Decodable {
    let topImage: String
    let thumbImages: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSection: [String]
}
