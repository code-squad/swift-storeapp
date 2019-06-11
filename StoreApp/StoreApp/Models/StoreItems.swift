//
//  StoreItems.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation
import JSONDataFetcher

class StoreItems {
    
    //MARK: - Properties
    //MARK: Models
    let sectionInfo: SectionInfo
    private var storeItems = [StoreItem]()
    
    //MARK: - Methods
    //MARK: Subscript
    subscript(index: Int) -> StoreItem? {
        guard 0 <= index, index < storeItems.count else { return nil }
        return storeItems[index]
    }
    
    //MARK: Initialization
    init(storeItemsInitInfo: SectionInfo) {
        self.sectionInfo = storeItemsInitInfo
        let fetcher = JSONDataFetcher()
        let completion: ([StoreItem]) -> Void = { storeItems in
            let appendItems = { () -> Void in
                self.storeItems.append(contentsOf: storeItems)
            }
            let userInfo = [UserInfoKey.appendItems: appendItems]
            NotificationCenter.default.post(name: .storeItemsWillUpdate, object: self, userInfo: userInfo)
            for storeItem in storeItems {
                guard let url = URL(string: storeItem.image) else { continue }
                let cacheManager = CacheManager()
                cacheManager.cachingImage(with: url)
            }
        }
        fetcher.fetchStoreItems(fileName: storeItemsInitInfo.fileName, completion: completion)
    }
    
    init(defaultFileInfo: SectionInfo) {
        self.sectionInfo = defaultFileInfo
        guard let pathOfData = Bundle.main.path(forResource: defaultFileInfo.fileName,
                                                ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: pathOfData)),
            let items = try? JSONDecoder().decode([StoreItem].self, from: jsonData) else { return }
        storeItems.append(contentsOf: items)
    }
    
    //MARK: Instance
    func count() -> Int {
        return storeItems.count
    }
    
    func postReloadRow(section: Int, imageName: String) {
        for (index, item) in storeItems.enumerated() {
            guard item.image.lastPathComponent() == imageName else { continue }
            let userInfo = [UserInfoKey.indexPathWillReload: IndexPath(row: index,
                                                                       section: section)]
            NotificationCenter.default.post(name: .rowWillReload,
                                            object: nil,
                                            userInfo: userInfo)
        }
    }
}

extension JSONDataFetcher {
    func fetchStoreItems(fileName: String, completion: @escaping ([StoreItem]) -> Void) {
        guard let url = URL(string: Configuration.URL.storeItems + fileName) else { return }
        load(url: url) { (data) in
            let decoder = JSONDecoder()
            guard let storeItemJSON = try? decoder.decode(StoreItemJSON.self, from: data) else { return }
            completion(storeItemJSON.body)
        }
    }
}
