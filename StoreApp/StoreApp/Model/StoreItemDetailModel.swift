//
//  StoreItemDetailModel.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 17..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import os.log

class StoreItemDetailModel {
    
    var topIamge : String = ""
    
    var thumb_images : [String] = []
    
    var title : String = ""
    
    var product_description : String = ""
    
    var point : String = ""
    
    var delivery_info : String = ""
    
    var delivery_fee : String = ""
    
    var prices : [String] = []
    
    var detail_section : [String] = []
    
    /// json Data 를 받아서 생성
    init?(json: [String: Any]) {
        guard  let topIamge = json["topIamge"] as? String else {
            os_log("StoreItemDetailModel 생성실패 : topIamge")
            return nil
        }
        guard   let thumb_images = json["thumb_images"] as? [String]  else {
            os_log("StoreItemDetailModel 생성실패 : thumb_images")
            return nil
        }
        guard   let product_description = json["product_description"] as? String  else {
            os_log("StoreItemDetailModel 생성실패 : product_description")
            return nil
        }
        guard    let point = json["point"] as? String  else {
            os_log("StoreItemDetailModel 생성실패 : point")
            return nil
        }
        guard    let delivery_info = json["delivery_info"] as? String  else {
            os_log("StoreItemDetailModel 생성실패 : delivery_info")
            return nil
        }
        guard    let delivery_fee = json["delivery_fee"] as? String  else {
            os_log("StoreItemDetailModel 생성실패 : delivery_fee")
            return nil
        }
        guard    let prices = json["prices"] as? [String]  else {
            os_log("StoreItemDetailModel 생성실패 : prices")
            return nil
        }
        guard    let detail_section = json["detail_section"] as? [String]  else {
            os_log("StoreItemDetailModel 생성실패 : detail_section")
            return nil
        }
        
        self.topIamge = topIamge
        self.thumb_images = thumb_images
        self.product_description = product_description
        self.point = point
        self.delivery_info = delivery_info
        self.delivery_fee = delivery_fee
        self.prices = prices
        self.detail_section = detail_section
    }

    /// 타이틀은 이전 셀에서 넘겨받기때문에 직접 수정한다
    func set(title: String){
        self.title = title
    }
}
