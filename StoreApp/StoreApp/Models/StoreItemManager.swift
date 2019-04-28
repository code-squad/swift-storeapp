//
//  StoreItemManager.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 22..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class StoreItemManager {
    
    //MARK: - Properties
    private var storeItems = [StoreItems]()

    //MARK: - Methods
    //MARK: Subscript
    subscript(index: Int) -> StoreItems? {
        guard 0 <= index, index < storeItems.count else { return nil }
        return storeItems[index]
    }
    
    //MARK: Initialization
    init(initInfo: [String: SectionInfo]) {
        for (fileName, sectionInfo) in initInfo {
            let storeItems = StoreItems(sectionInfo: sectionInfo, fileName: fileName)
            self.storeItems.append(storeItems)
        }
    }
    
    //MARK: Instance
    func itemCount() -> Int {
        return storeItems.count
    }
    
    func index(of items: StoreItems) -> Int? {
        return storeItems.firstIndex(where: {$0 === items})
    }
}
