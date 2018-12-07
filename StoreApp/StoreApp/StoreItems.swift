//
//  StoreItems.swift
//  StoreApp
//
//  Created by oingbong on 06/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct StoreItems: Decodable {
    var data: [StoreItem]
    
    var count: Int {
        return data.count
    }
    
    subscript(index: Int) -> StoreItem {
        return data[index]
    }
}
