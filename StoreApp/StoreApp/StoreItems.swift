//
//  StoreItems.swift
//  StoreApp
//
//  Created by 윤동민 on 11/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

class StoreItems {
    private var storeItems: [StoreItem]
    
    init() {
        if let storeItems = JSONParser.parseJSONData() { self.storeItems = storeItems }
        else { storeItems = [] }
    }
    
    func count() -> Int {
        return storeItems.count
    }
    
    func access(at index: Int ,form: (StoreItem) -> Void) {
        form(storeItems[index])
    }
}
