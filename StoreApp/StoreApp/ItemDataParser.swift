//
//  ItemDataParser.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 28..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class ItemDataParser {

    let decoder = JSONDecoder()

    func extractData() -> Data? {
        let path = Bundle.main.path(forResource: "main", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }

    func makeitemData(from data: Data?) -> Codable? {
        guard let datum = data else { return nil }
        guard let items = try? decoder.decode([ItemData].self, from: datum) else { return nil }
        return items
    }
}
