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
        }
        fetcher.fetchStoreItems(fileName: storeItemsInitInfo.fileName, completion: completion)
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
        let commonURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/"
        guard let url = URL(string: commonURL + fileName) else { return }
        load(url: url) { (data) in
            let decoder = JSONDecoder()
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let data = try? JSONSerialization.data(withJSONObject: json["body"], options: []),
                let items = try? decoder.decode([StoreItem].self, from: data) else { return }
            let urls = items.imageURLs()
            urls.downloadImages()
            completion(items)
        }
    }
}

extension Array where Element == StoreItem {
    func imageURLs() -> [ImageURL] {
        return self.compactMap { item -> ImageURL? in
            guard let url = URL(string: item.image) else { return nil }
            return ImageURL(url: url)
        }
    }
}

extension Array where Element == ImageURL {
    func downloadImages() {
        for url in self {
            url.downloadImage()
        }
    }
}
