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

    enum CodingKeys: String, CodingKey {
        case hash
        case data
    }
}
