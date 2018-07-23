//
//  StoreItems.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 9..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class StoreItems {
    static let categories: [Category] = [.main, .soup, .side]
    var storeItem: [Category: Items]

    init() {
        self.storeItem = [Category.main: Items(),
                          Category.soup: Items(),
                          Category.side: Items()]
    }

    subscript(index: Int) -> Items {
        get {
            return storeItem[StoreItems.categories[index]]!
        }
    }

    func isEmpty() -> Bool {
        return self.storeItem.count == 0
    }

    func countOfHeaders() -> Int {
        return self.storeItem.keys.count
    }

    func category() -> Category {
        return self.storeItem.keys.first!
    }

    func update(key: Category, value: Items) {
        self.storeItem[key] = value
    }

    func set(with category: Category) {
        URLSession.shared.dataTask(with: category.url) { [self, category] (data, response, error) in
            if let error = error {
                print("DataTask error: \(error)\n")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                let items = ItemDataParser.makeStoreItemsFromSession(category: category, data: data)
                self.setFromURL(items)
            } else {
                print("DataTask error: response \n")
                return
            }
        }.resume()
    }

    func setFromURL(_ items: [Category: Items]) {
        self.update(key: items.keys.first!, value: items.values.first!)
        let temp = IndexPath(row: 1, section: 0)
        let indexPath = Array(0..<self.storeItem[items.keys.first!]!.count()).map {IndexPath(row: $0, section: items.keys.first!.hashValue)}
        NotificationCenter.default.post(name: .sectionSetComplete, object: self, userInfo: [Keyword.sectionPath : indexPath])

    }
}

struct Items {
    let items: [ItemData]

    init() {
        self.items = []
    }

    init(data: [ItemData]) {
        self.items = data
    }

    subscript(index: Int) -> ItemData {
        get {
            return items[index]
        }
    }

    func count() -> Int {
        return self.items.count
    }

}

struct ItemData: Codable {
    var detail_hash: String
    var image: String
    var alt: String
    var delivery_type: [String]
    var title: String
    var description: String
    var n_price: String?
    var s_price: String
    var badge: [String]?
}

extension Dictionary where Key == Category {
    func firstKey() -> Category {
        return self.keys.first!
    }
}

