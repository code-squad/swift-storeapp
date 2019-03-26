//
//  StoreItemManager.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 26..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

class StoreItemManager {
    var storeItemList : [StoreItem]
    
    init(storeItemList: [StoreItem]){
        self.storeItemList = storeItemList
    }
    
    /// 인덱스를 받아서 해당 객체를 리턴한다
    func getStoreItem(index: Int) -> StoreItem {
        return self.storeItemList[index]
    }
    
    /// 카운트를 리턴한다
    func count() -> Int {
        return self.storeItemList.count
    }
}
