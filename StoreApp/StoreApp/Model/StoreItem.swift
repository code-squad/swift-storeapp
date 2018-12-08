//
//  StoreItem.swift
//  StoreApp
//
//  Created by oingbong on 06/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    var detail_hash: String
    var image: String
    var alt: String
    var delivery_type: [String]
    var title: String
    var description: String
    var n_price: String?
    var s_price: String
    var badge: [String]?
}
