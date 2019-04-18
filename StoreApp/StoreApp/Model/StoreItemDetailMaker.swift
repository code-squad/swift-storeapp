//
//  StoreItemDetailMaker.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 17..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import os.log

class StoreItemDetailMaker {
    /// 생성자 사용 못하게 숨김
    private init(){}
    
    /// json 배열을 받아서 스토어아이템 배열로 리턴
    class func makeStoreItemDetailModel(anyData: Data) -> StoreItemDetailModel? {
        // data 를 JSON 으로 변환
        guard let data = StoreItemMaker.jsonSerialization(jsonData: anyData) else {
            return nil
        }
        
        // json data 를 사전형으로 변환
        guard let checkedJSONData = data as? [String : Any] else {
             os_log("jsondata 에서 디테일모델용 data 생성 실패")
            return nil
        }
        
        // data 를 키로 문자열배열 추출
        guard let jsonData = checkedJSONData["data"] as? [String : Any] else {
            os_log("jsondata 에서 디테일모델용 data 생성 실패")
            return nil
        }
        
        // 디테일 모델 생성
        let detailModel = StoreItemDetailModel()
        
        let result = detailModel.setting(json: jsonData)
        
        guard result == true else {
             os_log("스토어아이템 디테일모델 생성 실패")
            return nil
        }
        
        //결과리턴
        return detailModel
    }
    
}
