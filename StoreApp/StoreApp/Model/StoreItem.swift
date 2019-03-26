//
//  Product.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class StoreItem : Codable{
    
    let detail_hash : String
    
    let image : String
    
    let alt : String
    
    let delivery_type : [String]
    
    let title : String
    
    let description : String
    
    let s_price : String
    
    init?(json: [String: Any]) {
        guard
            let detail_hash = json["detail_hash"] as? String,
            let image = json["image"] as? String,
            let alt = json["alt"] as? String,
            let delivery_type = json["delivery_type"] as? [String],
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let s_price = json["s_price"] as? String
        else { return nil }
        
        self.detail_hash = detail_hash
        self.image = image
        self.alt = alt
        self.delivery_type = delivery_type
        self.title = title
        self.description = description
        self.s_price = s_price
    }
}

/// 스토어아이템 리스트를 전역변수로 선언한다
var storeItems : [StoreItem] = {
    StoreItemMaker().makeStoreItem()
}()
