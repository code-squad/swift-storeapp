//
//  StoreItems.swift
//  StoreApp
//
//  Created by 윤동민 on 11/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let setMain = NSNotification.Name(rawValue: "setMain")
    static let setSoup = NSNotification.Name(rawValue: "setSoup")
    static let setSide = NSNotification.Name(rawValue: "setSide")
}

class StoreItems {
    private var mainItems: [StoreItem] = []
    private var soupItems: [StoreItem] = []
    private var sideItems: [StoreItem] = []
    
    init() {}
    
    func getDataFromNetwork() {
        NetworkHandler.getData(from: ServerURL.main)
        NetworkHandler.getData(from: ServerURL.soup)
        NetworkHandler.getData(from: ServerURL.side)
    }
    
    func setMain(_ items: [StoreItem]) {
        self.mainItems = items
        NotificationCenter.default.post(name: .setMain, object: nil)
    }
    
    func setSoup(_ items: [StoreItem]) {
        self.soupItems = items
        NotificationCenter.default.post(name: .setSoup, object: nil)
    }
    
    func setSide(_ items: [StoreItem]) {
        self.sideItems = items
        NotificationCenter.default.post(name: .setSide, object: nil)
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
}
