//
//  ItemDataParser.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 28..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class ItemDataParser {

    class func makeStoreItemsFromJSON(with category: Category) -> [Category: Items] {
        var result = [Category: Items]()
        result[category] = parse(fileName: category)
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

    private class func parseDatafromSession(data: Data) -> Items {
        guard let items = makeitemData(from: data) as? [ItemData] else { return Items(data:[]) }
        return Items(data: items)
    }

    class func makeStoreItemsFromSession(category: Category, data: Data) -> [Category: Items] {
        var result = [Category: Items]()
        result[category] = parseDatafromSession(data: data)
        return result
    }
}
