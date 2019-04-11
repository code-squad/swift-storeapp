//
//  JSONDecoder.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 26..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import os

class StoreItemMaker {
    /// json 배열을 받아서 스토어아이템 배열로 리턴
    static private func makeStoreItemList(jsonArray: Array<[String : Any]>) -> [StoreItem] {
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
    
    /// json data 를 받아서 스토어아이템 배열로 만들어서 리턴
    static func makeStoreItemList(jsonData: Data) -> [StoreItem] {
        // 리턴용 변수
        var result : [StoreItem] = []
        // path 에서 추출시도
        do {
            // 데이터 json 형태로 추출
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
            os_log("data 에서 json 추출")
            // json 데이터를 배열로 추출
            if let jsonDict = jsonResult as? [String : Any] {
                
                if let jsonList = jsonDict["body"] as? Array<[String : Any]> {
                    // json 배열의 모든 객체를 추가시도
                    result = makeStoreItemList(jsonArray: jsonList)
                    
                    os_log("json data -> StoreItem 배열로 생성 성공")
                    
                    // 추가가 성공하면 리턴
                    return result
                }
                
            } // json 을 추출은 했지만 스토어아이템 배열화 실패시
            else {
                os_log("스토어아이템 배열화 실패")
                return result
            }
        } catch {
            // 에러시
            os_log("json 전체 파싱 실패")
            return result
        }
        return result
    }
}
