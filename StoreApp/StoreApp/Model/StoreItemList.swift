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
    private var listTitle: String
    private var listDescription: String
    
    init?(_ foodCategory: FoodCategory) {
        listTitle = foodCategory.title
        listDescription = foodCategory.description
        DataManager.fetchStoreItemsFromStoreAPI(foodCategory) { [unowned self] storeItems in
            DispatchQueue.customSerialQueue.async {
                self.storeItems = storeItems
                NotificationCenter.default.post(name: .didStoreItemsSet, object: self, userInfo: ["sectionInfo":foodCategory])
            }
        }
    }
    
    var count: Int {
        return storeItems.count
    }
    
    subscript(index: Int) -> StoreItem {
        return storeItems[index]
    }
}

extension StoreItemList: LabelTextSettable {
    var title: String {
        return listTitle
    }
    
    var description: String {
        return listDescription
    }
}

extension DispatchQueue {
    static let customSerialQueue = DispatchQueue(label: "customSerial")
}
