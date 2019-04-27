//
//  StoreItems.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class StoreItems {
    
    //MARK: - Properties
    //MARK: Models
    let sectionInfo: SectionInfo
    private var storeItems: [StoreItem]
    
    //MARK: - Methods
    //MARK: Subscript
    subscript(index: Int) -> StoreItem? {
        guard 0 <= index, index < storeItems.count else { return nil }
        return storeItems[index]
    }
    
    //MARK: Initialization
    init(sectionInfo: SectionInfo, storeItems: [StoreItem]) {
        self.sectionInfo = sectionInfo
        self.storeItems = storeItems
    }
    
    //MARK: Instance
    func count() -> Int {
        return storeItems.count
    }
    
    func update(with data: Data) {
        let decoder = JSONDecoder()
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let jsonData = try? JSONSerialization.data(withJSONObject: json["body"], options: []),
            let items = try? decoder.decode([StoreItem].self, from: jsonData) else { return }
        self.storeItems = items
    }
}
