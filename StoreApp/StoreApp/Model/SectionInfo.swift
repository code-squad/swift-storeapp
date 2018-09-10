//
//  SectionInfo.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

class SectionInfo {
    private var storeItemLists: [StoreItemsFetchable] = []
    
    init() {
        self.storeItemLists = FoodCategory.allCases.map { StoreItemList($0) }
        NotificationCenter.default.addObserver(self, selector: #selector(self.fetchStoreItemFromStoreAPI(_:)), name: .connectionDidChanged, object: nil)
    }
    
    var count: Int {
        return storeItemLists.count
    }
    
    subscript(index: Int) -> StoreItemList? {
        guard let storeItemList = storeItemLists[index] as? StoreItemList else { return nil }
        return storeItemList
    }
    
    @objc func fetchStoreItemFromStoreAPI(_ notification: Notification) {
        guard let reachabilityListener = notification.object as? ReachabilityListener else { return }
        storeItemLists.forEach {
            reachabilityListener.isReachable ? $0.fetchStoreItemsFromAPI() : $0.fetchSotreItemsFromFile()
        }
    }
}
