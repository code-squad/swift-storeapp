//
//  StoreItems.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct StoreItems {
    
    //MARK: - Properties
    //MARK: Models
    private var storeItems: [StoreItem]
    
    //MARK: - Methods
    //MARK: Subscript
    subscript(index: Int) -> StoreItem? {
        guard 0 <= index, index < storeItems.count else { return nil }
        return storeItems[index]
    }
    
    //MARK: Initialization
    init(storeItems: [StoreItem]) {
        self.storeItems = storeItems
    }
    
    //MARK: Instance
    func count() -> Int {
        return storeItems.count
    }
}
