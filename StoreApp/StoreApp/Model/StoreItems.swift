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
    
    func getDataFromNetwork() {
        for url in ServerURL.allCases { NetworkHandler.getData(from: url) }
    }
    
    func countCategory() -> Int {
        return SectionTheme.allCases.count
    }
    
    func countItems(at section: Int) -> Int {
        guard let theme = SectionTheme(rawValue: section) else { return 0 }
        switch theme {
        case .main: return mainItems.count
        case .soup: return soupItems.count
        case .side: return sideItems.count
        }
    }
    
    func access(of theme: Int, at index: Int, form: (StoreItem) -> Void) {
        guard let theme = SectionTheme(rawValue: theme) else { return }
        switch theme {
        case .main: form(mainItems[index])
        case .soup: form(soupItems[index])
        case .side: form(sideItems[index])
        }
    }
    
    func setMainItem(_ items: [StoreItem]) {
        self.mainItems = items
    }
    
    func setSoupItem(_ items: [StoreItem]) {
        self.soupItems = items
    }
    
    func setSideItem(_ items: [StoreItem]) {
        self.sideItems = items
    }
}
