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
    
    var n_price : String = ""
    
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
        // n_price 는 없을수도 있음. 있으면 값 입력, 없으면 기본값 유지
        if let nPrice = json["n_price"] as? String {
            self.n_price = nPrice + "  "
        }
    }
    
    /// 자신의 제목과 가격을 리턴한다.
    func toastMessage() -> String {
        return "\(self.title) : \(self.s_price)"
    }
}
