//
//  Product.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os

class StoreItem : Decodable {
    
    let detail_hash : String
    
    let image : String
    
    let alt : String
    
    var badge : [String] = []
    
    let title : String
    
    let description : String
    
    let s_price : String
    
    var n_price : String = ""
    
    lazy var imageFileURL = ""
    
    init?(json: [String: Any]) {
        guard  let detail_hash = json["detail_hash"] as? String else {
            os_log("StoreItem 생성실패 : detail_hash")
            return nil
        }
         guard   let image = json["image"] as? String  else {
            os_log("StoreItem 생성실패 : image")
            return nil
        }
         guard   let alt = json["alt"] as? String  else {
            os_log("StoreItem 생성실패 : alt")
            return nil
        }
        guard    let title = json["title"] as? String  else {
            os_log("StoreItem 생성실패 : title")
            return nil
        }
        guard    let description = json["description"] as? String  else {
            os_log("StoreItem 생성실패 : description")
            return nil
        }
        
        guard    let s_price = json["s_price"] as? String  else {
            os_log("StoreItem 생성실패 : s_price")
            return nil
        }
        
        self.detail_hash = detail_hash
        self.image = image
        self.alt = alt
        
        // 배지가 있을경우
        if let badge = json["badge"] as? [String] {
            self.badge = badge
        }
        
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
