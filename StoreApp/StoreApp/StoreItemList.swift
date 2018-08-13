//
//  StoreItemList.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct StoreItemList {
    private var storeItems: [StoreItem]
    
    subscript(index: Int) -> StoreItem {
        return storeItems[index]
    }
}
