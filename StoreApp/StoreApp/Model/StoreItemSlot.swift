//
//  StoreItemManager.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 26..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

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
    
    /// 내부 리스트를 리턴하고 본래 리스트는 비운다.
    func allItems() -> [StoreItem] {
        // 리턴용 변수에 기존값을 연결한다
        let result = self.storeItemList
        
        // 기존값은 비운다
        self.storeItemList = []
        
        // 결과 리턴
        return result
    }
    
    /// 슬롯을 받아서 자기자신에 추가한다
    func add(storeItemSlot: StoreItemSlot){
        // 리스트 추출
        let itemList = storeItemSlot.allItems()
        
        // 리스트를 자기자신에 추가한다
        for item in itemList{
            self.storeItemList.append(item)
        }
    }
}
