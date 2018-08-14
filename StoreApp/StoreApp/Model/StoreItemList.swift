//
//  StoreItemList.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class StoreItemList {
    private var storeItems: [StoreItem] = []
    
    init(storeItems: [StoreItem]) {
        self.storeItems = storeItems
    }
    
    var count: Int {
        return storeItems.count
    }
    
    func add(storeItems: [StoreItem]) {
        self.storeItems.append(contentsOf: storeItems)
    }
    
    subscript(index: Int) -> StoreItem {
        return storeItems[index]
    }
}
