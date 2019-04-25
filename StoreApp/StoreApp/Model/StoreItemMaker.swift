//
//  JSONDecoder.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 26..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import os.log

class StoreItemMaker {
    /// json 배열을 받아서 스토어아이템 배열로 리턴
    class private func makeStoreItemList(jsonArray: Array<[String : Any]>) -> [StoreItem] {
        // 결과리턴배열
        var result : [StoreItem] = []
        
        // json 배열의 모든 객체를 추가시도
        for json in jsonArray {
            // 배열화된 json 을 물품객체로 생성
            guard let newItem = StoreItem(json: json) else {
                // 에러시
                os_log("json 1개 품목 파싱 실패 : %@",json["title"] as! CVarArg)
                continue
            }
            // 생성된 물품을 배열에 추가
            result.append(newItem)
            os_log("json 파싱 성공 : %@",newItem.title)
        }
        //결과리턴
        return result
    }
    
    /// jsonData 를 받아서 any 형으로 리턴. json 분석을 거친다.
    class func jsonSerialization(jsonData: Data) -> Any? {
        do {
            // 데이터 json 형태로 추출
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
            return jsonResult
            
        } catch {
            // 에러시
            os_log("data 에서 JSON 변환 실패")
            return nil
        }
    }
    
    /// json data 를 받아서 스토어아이템 배열로 만들어서 리턴
    class func makeStoreItemList(jsonData: Data) -> [StoreItem] {
        // 리턴용 변수
        var result : [StoreItem] = []
        // path 에서 추출시도
        guard let jsonResult = jsonSerialization(jsonData: jsonData) else {
            return result
        }
        os_log("data 에서 json 추출")
        // json 데이터를 배열로 추출
        guard let jsonDict = jsonResult as? [String : Any] else {
            // json 을 추출은 했지만 스토어아이템 배열화 실패시
            os_log("스토어아이템 배열화 실패")
            return result
        }
        
        if let jsonList = jsonDict["body"] as? Array<[String : Any]> {
            // json 배열의 모든 객체를 추가시도
            result = makeStoreItemList(jsonArray: jsonList)
            
            os_log("json data -> StoreItem 배열로 생성 성공")
        }
        return result
    }    
}

class OrderResult: Codable {
    /// 주문결과 텍스트
    let text : String
    
    init(customerName: String, price: String, menu: String){
        self.text = "\(customerName) 님이 \(price)원 짜리 \(menu) 를 구입하셨습니다."
    }
}


