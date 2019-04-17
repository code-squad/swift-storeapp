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
        guard let mainItemsData = FileReader.getTextFrom(file: FileName.mainItem),
              let soupItemsData = FileReader.getTextFrom(file: FileName.soupItem),
              let sideItemsData = FileReader.getTextFrom(file: FileName.sideItem) else { return }
        guard let mainItems = JSONParser.parseJSONData(from: mainItemsData),
              let soupItems = JSONParser.parseJSONData(from: soupItemsData),
              let sideItems = JSONParser.parseJSONData(from: sideItemsData) else { return }
        self.mainItems = mainItems
        self.soupItems = soupItems
        self.sideItems = sideItems
    }
    
    func countItems(at section: Int) -> Int {
        guard let theme = SectionTheme(rawValue: section) else { return 0 }
        switch theme {
        case .main: return mainItems.count
        case .soup: return soupItems.count
        case .side: return sideItems.count
        }
    }
    
    func count() -> Int {
        return mainItems.count
    }
    
    func access(of theme: Int, at index: Int, form: (StoreItem) -> Void) {
        guard let theme = SectionTheme(rawValue: theme) else { return }
        switch theme {
        case .main: form(mainItems[index])
        case .soup: form(soupItems[index])
        case .side: form(sideItems[index])
        }
    }
}
