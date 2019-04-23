//
//  StoreItemManager.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 22..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct StoreItemManager {
    
    //MARK: - Properties
    private var storeItems = [StoreItems]()

    //MARK: - Methods
    //MARK: Subscript
    subscript(index: Int) -> StoreItems? {
        guard 0 <= index, index < storeItems.count else { return nil }
        return storeItems[index]
    }
    
    //MARK: Initialization
    init() {
        guard let items = fetchStoreItems(with: "main") else { return }
        self.storeItems.append(items)
    }
    
    //MARK: Private
    private func fetchStoreItems(with resourceName: String) -> StoreItems? {
        guard let pathOfData = Bundle.main.path(forResource: resourceName, ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: pathOfData),
                                     options: .mappedIfSafe),
            let items = try? JSONDecoder().decode([StoreItem].self, from: jsonData) else { return nil }
        return StoreItems(storeItems: items)
    }
    
    //MARK: Instance
    func itemCount() -> Int {
        return storeItems.count
    }
}
