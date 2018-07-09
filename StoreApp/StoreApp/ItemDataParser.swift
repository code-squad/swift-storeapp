//
//  ItemDataParser.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 28..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class ItemDataParser {

    private class func extractData() -> Data? {
        let path = Bundle.main.path(forResource: "main", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }

    private class func makeitemData(from data: Data?) -> Codable? {
        let decoder = JSONDecoder()
        guard let datum = data else { return nil }
        guard let items = try? decoder.decode([ItemData].self, from: datum) else { return nil }
        return items
    }

    class func parse() -> [ItemData] {
        guard let data = extractData() else {
            print("Failed to parse")
            return []
        }
        guard let items = makeitemData(from: data) as? [ItemData] else { return [] }
        return items
    }

}
