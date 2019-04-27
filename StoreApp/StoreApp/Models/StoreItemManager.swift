//
//  StoreItemManager.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 22..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class StoreItemManager {
    
    //MARK: - Properties
    private var storeItems = [StoreItems]()

    //MARK: - Methods
    //MARK: Subscript
    subscript(index: Int) -> StoreItems? {
        guard 0 <= index, index < storeItems.count else { return nil }
        return storeItems[index]
    }
    
    //MARK: Initialization
    init(initInfo: [String: SectionInfo]) {
        for (fileName, sectionInfo) in initInfo {
            guard let items = fetchStoreItems(with: fileName) else { continue }
            let storeItems = StoreItems(sectionInfo: sectionInfo, storeItems: items)
            self.storeItems.append(storeItems)
        }
    }
    
    //MARK: Private
    private func fetchStoreItems(with resourceName: String) -> [StoreItem]? {
        guard let pathOfData = Bundle.main.path(forResource: resourceName, ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: pathOfData),
                                     options: .mappedIfSafe),
            let items = try? JSONDecoder().decode([StoreItem].self, from: jsonData) else { return nil }
        return items
    }
    
    //MARK: Instance
    func itemCount() -> Int {
        return storeItems.count
    }
    
    func update(with updateInfo: [String: String]) {
        let commonURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/"
        for (fileName, sectionTitle) in updateInfo {
            let fetcher = JSONDataFetcher()
            guard let url = URL(string: commonURL + fileName),
                let items = storeItems.first(where: {$0.sectionInfo.title == sectionTitle}) else { continue }
            fetcher.load(with: url) { (data) in
                items.update(with: data)
            }
        }
    }
}
