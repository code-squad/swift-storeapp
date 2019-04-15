//
//  StoreItems.swift
//  StoreApp
//
//  Created by 윤동민 on 11/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

class StoreItems {
    private var mainItems: [StoreItem] = []
    private var soupItems: [StoreItem] = []
    private var sideItems: [StoreItem] = []
    
    init() {
        guard let mainItemsData = JSONParser.getText(from: FileURL.mainItemURL),
              let soupItemsData = JSONParser.getTextFrom(file: "soup.json"),
              let sideItemsData = JSONParser.getTextFrom(file: "side.json") else { return }
        guard let mainItems = JSONParser.parseJSONData(from: mainItemsData),
              let soupItems = JSONParser.parseJSONData(from: soupItemsData),
              let sideItems = JSONParser.parseJSONData(from: sideItemsData) else { return }
        self.mainItems = mainItems
        self.soupItems = soupItems
        self.sideItems = sideItems
        
        print("""
            mainItems: \(mainItems)
            soupItems: \(soupItems)
            sideItems: \(sideItems)
            """)
    }
    
    func count() -> Int {
        return mainItems.count
    }
    
    func access(at index: Int ,form: (StoreItem) -> Void) {
        form(mainItems[index])
    }
}
