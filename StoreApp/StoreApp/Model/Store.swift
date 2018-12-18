//
//  Store.swift
//  StoreApp
//
//  Created by oingbong on 11/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class Store {
    private var storeItemGroup = [StoreItemGroup]() {
        didSet {
            NotificationCenter.default.post(name: NotificationKey.updateItem, object: nil)
        }
    }
    
    var storeItemGroupCount: Int {
        return storeItemGroup.count
    }
    
    func appendItem() {
        for item in Topic.allCases {
            parseUrl(topic: item) { (storeItemGroup) in
                self.imageUrl(at: item.rawValue, with: storeItemGroup)
            }
        }
    }
    
    // MARK: for file
    private func parse(topic: String) -> [StoreItem]? {
        guard let jsonData = Parser.json(fileName: topic), let items: [StoreItem] = Parser.decode(from: jsonData) else {
            NotificationCenter.default.post(name: NotificationKey.error, object: nil)
            return nil
        }
        return items
    }
    
    // MARK: for url
    private func parseUrl(topic: Topic, handler: @escaping (StoreItemGroup) -> Void ) {
        Parser.jsonUrl(fileName: topic.englihsName) { (storeItems) in
            guard let items = storeItems, let storeItems: [StoreItem] = Parser.decode(from: items) else {
                NotificationCenter.default.post(name: NotificationKey.error, object: nil)
                return
            }
            let storeItemGroup = StoreItemGroup(sectionName: topic.englihsName, sectionObjects: storeItems)
            self.storeItemGroup.append(storeItemGroup)
            handler(storeItemGroup)
        }
    }
    
    // MARK: for image
    private func imageUrl(at sectionIndex: Int, with storeItemGroup: StoreItemGroup) {
        for index in 0..<storeItemGroup.sectionObjects.count {
            guard let url = URL(string: storeItemGroup.sectionObjects[index].image) else { return }
            DispatchQueue.global().async {
                Parser.imageDownLoad(with: url, handler: { (isSuccess) in
                    if isSuccess {
                        NotificationCenter.default.post(name: NotificationKey.updateItemCell, object: nil, userInfo: ["section": sectionIndex, "row": index])
                    }
                })
            }
        }
    }

    subscript(index: Int) -> StoreItemGroup {
        return storeItemGroup[index]
    }
}
