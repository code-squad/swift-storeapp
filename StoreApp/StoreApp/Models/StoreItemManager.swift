//
//  StoreItemManager.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 22..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct StoreItemManager {
    
    private let storeItems: StoreItems?
    
    subscript(index: Int) -> StoreItem? {
        return storeItems?[index]
    }
    
    init() {
        guard let pathOfData = Bundle.main.path(forResource: "main", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: pathOfData),
                                     options: .mappedIfSafe),
            let items = try? JSONDecoder().decode([StoreItem].self, from: jsonData) else {
                storeItems = nil
                return
        }
        self.storeItems = StoreItems(storeItems: items)
    }
    
    func itemCount() -> Int {
        return storeItems?.count() ?? 0
    }
}
