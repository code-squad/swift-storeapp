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
    
    func sectionTitle(at index: Int) -> String {
        return storeItemLists[index].title
    }
    
    func sectionDescription(at index: Int) -> String {
        return storeItemLists[index].description
    }
    
    subscript(index: Int) -> StoreItemList {
        return storeItemLists[index]
    }
}
