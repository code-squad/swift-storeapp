//
//  StoreItemContainer.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 28..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class StoreItemContainer {
    var storeItemSlotList : [StoreItemSlot] = []
    
    init(){}
    
    
    /// 스토어아이템 슬롯을 받아서 추가한다
    func add(storeItemSlot: StoreItemSlot) {
        self.storeItemSlotList.append(storeItemSlot)
    }
    
    /// 스토어아이템 슬롯 번호를 받아서 count 를 리턴한다
    func count(index: Int) -> Int {
        return self.storeItemSlotList[index].count()
    }
    
    /// 인덱스패스를 받아서 해당 아이템을 리턴
    func storeItem(indexPath: IndexPath) -> StoreItem {
        return self.storeItemSlotList[indexPath.section].storeItem(index: indexPath.row)
    }
    
    /// 전체 스토어아이템 슬롯의 count 리턴
    func count() -> Int {
        return self.storeItemSlotList.count
    }
}
