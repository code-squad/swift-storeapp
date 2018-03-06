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
