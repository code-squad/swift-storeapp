//
//  SectionInfo.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct SectionInfo {
    private var storeItemLists: [StoreItemList]
    
    init(categories: [FoodCategory]) {
        self.storeItemLists = categories.compactMap { StoreItemList($0) }
    }
    
    var count: Int {
        return storeItemLists.count
    }
    
    subscript(index: Int) -> StoreItemList {
        return storeItemLists[index]
    }
}
