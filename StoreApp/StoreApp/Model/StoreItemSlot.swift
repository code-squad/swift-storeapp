//
//  StoreItemManager.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 26..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation
import os

class StoreItemSlot {
    private var storeItemList : [StoreItem] = []
    
    init(storeItemList: [StoreItem]){
        self.storeItemList = storeItemList
    }
    
    init(){}
    
    /// 인덱스를 받아서 해당 객체를 리턴한다
    func storeItem(index: Int) -> StoreItem {
        return self.storeItemList[index]
    }
    
    /// 카운트를 리턴한다
    func count() -> Int {
        return self.storeItemList.count
    }
    
    /// 인덱스를 받아서 해당 객체의 토스트 메세지를 리턴한다
    func toastMessage(index: Int) -> String {
        return self.storeItemList[index].toastMessage()
    }
    
    /// 스토어아이템 배열을 받아서 추가한다
    func add(storeItemList: [StoreItem], index: Int){
        for item in storeItemList {
            self.storeItemList.append(item)
        }
        // 추가가 완료되면 노티생성
        
        // 로깅을 위한 정수형 -> 문자형 변환
        let indexString : String = String(index)
        os_log("데이터소스에 슬롯추가완료. index : %@",indexString)
        
        NotificationCenter.default.post(name: .didAddStoreItemSlot, object: index)
        os_log("노티 발생 완료. index : %@",indexString)
    }
}
