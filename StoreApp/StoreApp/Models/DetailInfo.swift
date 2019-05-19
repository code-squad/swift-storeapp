//
//  DetailInfo.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 19..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct DetailInfo: Decodable {
    let top_image: String
    let thumb_images: [String]
    let product_description: String
    let point: String
    let delivery_info: String
    let delivery_fee: String
    let prices: [String]
    let detail_section: [String]
}
