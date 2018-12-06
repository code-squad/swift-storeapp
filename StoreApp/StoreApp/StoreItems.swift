//
//  StoreItems.swift
//  StoreApp
//
//  Created by oingbong on 06/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct StoreItems {
    var items: [StoreItem]
    
    subscript(index: Int) -> StoreItem {
        return items[index]
    }
}
