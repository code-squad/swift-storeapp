//
//  StoreItemList.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class StoreItemList {
    private var storeItems: [StoreItem]
    
    init?(jsonFileName: String) {
        guard let data = DataManager.readDataFromJson(fileName: jsonFileName) else { return nil }
        guard let storeItems = DataManager.decode(data: data, type: [StoreItem].self) else { return nil }
        self.storeItems = storeItems
    }
    
    var count: Int {
        return storeItems.count
    }
    
    subscript(index: Int) -> StoreItem {
        return storeItems[index]
    }
}
