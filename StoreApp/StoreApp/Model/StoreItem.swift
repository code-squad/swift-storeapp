//
//  StoreItem.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    let detailHash, image, alt, description, sPrice, title: String
    let nPrice: String?
    
    let deliveryType, badge: [String]?
}
