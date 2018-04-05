//
//  StoreItems.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class StoreItems {
    var storeItems = [StoreItem]()

    subscript(index: Int) -> StoreItem? {
        guard index >= storeItems.count else { return nil }
        return storeItems[index]
    }
}
