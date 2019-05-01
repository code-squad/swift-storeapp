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
}

extension NSNotification.Name {
    static let storeItemsWillUpdate = NSNotification.Name("storeItemsDidUpdate")
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
            completion(items)
        }
    }
}

struct UserInfoKey {
    static let appendItems = "appendItems"
}
