//
//  Store.swift
//  StoreApp
//
//  Created by oingbong on 11/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class Store {
    private var topic = [Topic]()
    private var storeItemGroup = [StoreItemGroup]() {
        didSet {
            NotificationCenter.default.post(name: NotificationKey.updateItem, object: nil)
            if topic.count == storeItemGroup.count {
                imageUrl()
            }
        }
    }
    
    var storeItemGroupCount: Int {
        return storeItemGroup.count
    }
    
    init() {
        appendTopic()
    }
    
    private func appendTopic() {
        let main = Topic(englihsName: "main", koreanName: "메인반찬", desc: "한그릇 뚝딱 메인 요리")
        let soup = Topic(englihsName: "soup", koreanName: "국.찌게", desc: "김이 모락모락 국.찌게")
        let side = Topic(englihsName: "side", koreanName: "밑반찬", desc: "언제 먹어도 든든한 밑반찬")
        topic.append(main)
        topic.append(soup)
        topic.append(side)
    }
    
    func appendItem() {
        for item in topic {
            parseUrl(topic: item.englihsName)
        }
    }
    
    // for file
    private func parse(topic: String) -> [StoreItem]? {
        guard let jsonData = Parser.json(fileName: topic), let items: [StoreItem] = Parser.decode(from: jsonData) else {
            NotificationCenter.default.post(name: NotificationKey.error, object: nil)
            return nil
        }
        return items
    }
    
    // for url
    private func parseUrl(topic: String) {
        Parser.jsonUrl(fileName: topic) { (storeItems) in
            guard let items = storeItems, let storeItems: [StoreItem] = Parser.decode(from: items) else {
                NotificationCenter.default.post(name: NotificationKey.error, object: nil)
                return
            }
            self.storeItemGroup.append(StoreItemGroup(sectionName: topic, sectionObjects: storeItems))
        }
    }
    
    // for image
    private func imageUrl() {
        for groupIndex in 0..<storeItemGroup.count {
            for index in 0..<storeItemGroup[groupIndex].sectionObjects.count {
                DispatchQueue.global().async {
                    Parser.imageDownLoad(with: self.storeItemGroup[groupIndex].sectionObjects[index], handler: { (isSuccess) in
                        if isSuccess {
                            NotificationCenter.default.post(name: NotificationKey.updateItemCell, object: nil, userInfo: ["section": groupIndex, "row": index])
                        }
                    })
                }
            }
        }
    }
    
    subscript(index: Int) -> StoreItemGroup {
        return storeItemGroup[index]
    }
    
    subscript(index: Int) -> Topic {
        return topic[index]
    }
}
