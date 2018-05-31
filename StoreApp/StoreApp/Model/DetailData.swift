//
//  DetailData.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 28..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

struct DetailData: Decodable {
    
    let top_image: String
    let thumb_images: [String]
    let product_description: String
    let point: String
    let delivery_info: String
    let delivery_fee: String
    let prices: [String]
    let detail_section: [String]
    
}
