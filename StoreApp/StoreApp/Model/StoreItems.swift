//
//  StoreItems.swift
//  StoreApp
//
//  Created by 윤동민 on 11/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let setMain = NSNotification.Name("setMain")
    static let setSoup = NSNotification.Name("setSoup")
    static let setSide = NSNotification.Name("setSide")
}

class StoreItems {
    private var mainItems: [StoreItem] = []
    private var soupItems: [StoreItem] = []
    private var sideItems: [StoreItem] = []
    
    func getDataFromNetwork() {
        for url in ServerURL.allCases { NetworkHandler.getData(from: url) }
    }
    
    func downloadMainImageFromNetwork() {
        for index in 0..<mainItems.count {
            let imageURL = mainItems[index].getDTO().image
            NetworkHandler.downloadImage(from: imageURL, of: SectionTheme.main.rawValue, at: index)
        }
    }
    
    func downloadSoupImageFromNetwork() {
        for index in 0..<soupItems.count {
            let imageURL = soupItems[index].getDTO().image
            NetworkHandler.downloadImage(from: imageURL, of: SectionTheme.soup.rawValue, at: index)
        }
    }
    
    func downloadSideImageFromNetwork() {
        for index in 0..<sideItems.count {
            let imageURL = sideItems[index].getDTO().image
            NetworkHandler.downloadImage(from: imageURL, of: SectionTheme.side.rawValue, at: index)
        }
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
        NotificationCenter.default.post(name: .setMain, object: nil)
    }
    
    func setSoupItem(_ items: [StoreItem]) {
        self.soupItems = items
        NotificationCenter.default.post(name: .setSoup, object: nil)
    }
    
    func setSideItem(_ items: [StoreItem]) {
        self.sideItems = items
        NotificationCenter.default.post(name: .setSide, object: nil)
    }
}
