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
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(setMainItem(notification:)), name: .getMain, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSoupItem(notification:)), name: .getSoup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSideItem(notification:)), name: .getSide, object: nil)
    }
    
    func getDataFromNetwork() {
        NetworkHandler.getData(from: ServerURL.main)
        NetworkHandler.getData(from: ServerURL.soup)
        NetworkHandler.getData(from: ServerURL.side)
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
}

extension StoreItems {
    @objc func setMainItem(notification: NSNotification) {
        guard let mainItems = notification.userInfo?["main"] as? [StoreItem] else { return }
        self.mainItems = mainItems
        NotificationCenter.default.post(name: .setMain, object: nil)
    }
    
    @objc func setSoupItem(notification: NSNotification) {
        guard let soupItems = notification.userInfo?["soup"] as? [StoreItem] else { return }
        self.soupItems = soupItems
        NotificationCenter.default.post(name: .setSoup, object: nil)
    }
    
    @objc func setSideItem(notification: NSNotification) {
        guard let sideItems = notification.userInfo?["side"] as? [StoreItem] else { return }
        self.sideItems = sideItems
        NotificationCenter.default.post(name: .setSide, object: nil)
    }
}
