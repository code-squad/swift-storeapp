//
//  StoreItems.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct StoreItems {
    private var storeItems: [StoreItem]
    
    subscript(index: Int) -> StoreItem? {
        guard 0 <= index, index < storeItems.count else { return nil }
        return storeItems[index]
    }
    
    init?() {
        guard let pathOfData = Bundle.main.path(forResource: "main", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: pathOfData),
                                     options: .mappedIfSafe),
            let items = try? JSONDecoder().decode([StoreItem].self, from: jsonData) else { return nil }
        self.storeItems = items
    }
}
