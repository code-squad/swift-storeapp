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
    
    var top_image : String = ""
    
    var thumb_images : [String] = []
    
    var title : String = ""
    
    var product_description : String = ""
    
    var point : String = ""
    
    var delivery_info : String = ""
    
    var delivery_fee : String = ""
    
//    var prices : [String] = []
    var n_price = ""
    var s_price = ""
    
    var detail_section : [String] = []
    
    init(){}
    
    /// json Data 를 받아서 생성
    func setting(json: [String: Any]) -> Bool {
        guard  let top_image = json["top_image"] as? String else {
            os_log("StoreItemDetailModel 생성실패 : top_image")
            return false
        }
        guard   let thumb_images = json["thumb_images"] as? [String]  else {
            os_log("StoreItemDetailModel 생성실패 : thumb_images")
            return false
        }
        guard   let product_description = json["product_description"] as? String  else {
            os_log("StoreItemDetailModel 생성실패 : product_description")
            return false
        }
        guard    let point = json["point"] as? String  else {
            os_log("StoreItemDetailModel 생성실패 : point")
            return false
        }
        guard    let delivery_info = json["delivery_info"] as? String  else {
            os_log("StoreItemDetailModel 생성실패 : delivery_info")
            return false
        }
        guard    let delivery_fee = json["delivery_fee"] as? String  else {
            os_log("StoreItemDetailModel 생성실패 : delivery_fee")
            return false
        }
        guard    let prices = json["prices"] as? [String]  else {
            os_log("StoreItemDetailModel 생성실패 : prices")
            return false
        }
        guard    let detail_section = json["detail_section"] as? [String]  else {
            os_log("StoreItemDetailModel 생성실패 : detail_section")
            return false
        }
        
        self.top_image = top_image
        self.thumb_images = thumb_images
        self.product_description = product_description
        self.point = point
        self.delivery_info = delivery_info
        self.delivery_fee = delivery_fee
//        self.prices = prices
        self.detail_section = detail_section
        
        // 가격이 두개일 경우 순서대로 할인전, 지금가격.
        if prices.count > 1 {
            self.s_price = prices[0]
            self.n_price = prices[1]
        } // 1개면 지금가격
        else {
            self.n_price = prices[0]
        }
        
        // 설정 모두 완료
        return true
    }

    /// 타이틀은 이전 셀에서 넘겨받기때문에 직접 수정한다
    func set(title: String){
        self.title = title
    }
}
