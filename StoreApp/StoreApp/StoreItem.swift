//
//  StoreItem.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

class StoreItem: Decodable {
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
