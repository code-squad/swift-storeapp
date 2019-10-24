//
//  StoreItem.swift
//  StoreApp
//
//  Created by Summer on 24/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import Foundation

struct StoreItem:Codable{
    var detail_hash : String
    var image : String
    var alt : String
    var delivery_type : [String]
    var badge : [String]?
    var title : String
    var description : String
    var s_price : String
    var n_price : String?
}
