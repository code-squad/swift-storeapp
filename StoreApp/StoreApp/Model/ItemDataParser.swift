//
//  ItemDataParser.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 28..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class ItemDataParser {

    class func makeStoreItems() -> [Category: Items] {
        var result = [Category: Items]()
        for category in StoreItems.categories {
            result[category] = parse(fileName: category)
        }
        return result
    }

    private class func makeitemData(from data: Data?) -> Codable? {
        let decoder = JSONDecoder()
        guard let datum = data else { return nil }
        guard let items = try? decoder.decode([ItemData].self, from: datum) else { return nil }
        return items
    }

    private class func extractData(category: Category) -> Data? {
        let path = Bundle.main.path(forResource: category.rawValue, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }

    private class func parse(fileName category: Category) -> Items {
        guard let data = extractData(category: category) else {
            print("Failed to parse")
            return Items(data: [])
        }
        guard let items = makeitemData(from: data) as? [ItemData] else { return Items(data:[]) }
        return Items(data: items)
    }


}
