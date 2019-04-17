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
    
    /// json 배열을 받아서 스토어아이템 배열로 리턴
    static private func makeStoreItemList(jsonData: [String : Any]) -> StoreItemDetailModel? {
        // data 를 키로 문자열배열 추출
        guard let data = jsonData["data"] as? [String : Any] else {
             os_log("jsondata 에서 디테일모델용 data 생성 실패")
            return nil
        }
        
        guard let storeItemDetailModel = StoreItemDetailModel(json: data) else {
             os_log("스토어아이템 디테일모델 생성 실패")
            return nil
        }
        
        //결과리턴
        return storeItemDetailModel
    }
    
}
