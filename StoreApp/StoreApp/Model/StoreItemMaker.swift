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
    /// 전체 json 파일명 목록
    static private let allJSONFileName = ["main","side","soup"]
    
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
    
    /// json path 를 받아서 스토어아이템 배열로 만들어서 리턴
    static private func makeStoreItemList(jsonPath: String) -> [StoreItem] {
        // 리턴용 변수
        var result : [StoreItem] = []
        // path 에서 추출시도
        do {
            // 위치에서 데이터 추출
            let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe)
            // 데이터 json 형태로 추출
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            // json 데이터를 배열로 추출
            if let jsonList = jsonResult as? Array<[String : Any]> {
                // json 배열의 모든 객체를 추가시도
                result = makeStoreItemList(jsonArray: jsonList)
                // 추가가 성공하면 리턴
                return result
            } // json 을 추출은 했지만 스토어아이템 배열화 실패시
            else {
                os_log("json 을 추출 성공, 스토어아이템 배열화 실패")
                return result
            }
        } catch {
            // 에러시
            os_log("json 전체 파싱 실패")
            return result
        }
    }
    
    /// 스토어아이템 배열을 리턴한다
    static private func makeStoreItem(fileName: String) -> StoreItemSlot {
        // 물품 리스트 선언
        var storeItemList : [StoreItem] = []
        
        // json 파일 위치 찾기
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            storeItemList = makeStoreItemList(jsonPath: path)
        } // json 파일이 없을때
        else {
            os_log("json 파일이 없습니다. 파일명 : %@",fileName)
        }
        
        return StoreItemSlot(storeItemList: storeItemList)
    }
    
    /// 전체 스토어 아이템을 추출해서 컨테이너로 리턴한다
    static func makeStoreItemContainer() -> StoreItemContainer {
        // 결과용 변수
        let storeItemContainer = StoreItemContainer()
        
        // 모든 json 파일을 추출한다
        for fileName in self.allJSONFileName {
            let storeItemSlot = makeStoreItem(fileName: fileName)
            storeItemContainer.addStoreItemSlot(storeItemSlot: storeItemSlot)
        }
        // 결과리턴
        return storeItemContainer
    }
}
