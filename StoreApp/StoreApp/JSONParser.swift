//
//  JSONParser.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct JSONParser {
    static func parseJSONData(from jsonData: String) -> [StoreItem]? {
        let jsonDecoder = JSONDecoder()
        guard let data = jsonData.data(using: .utf8) else { return nil }
        return try? jsonDecoder.decode(Array<StoreItem>.self, from: data)
    }
    
    static func parseJSONData(_ data: Data) -> ItemFromHTTP? {
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(ItemFromHTTP.self, from: data)
    }
}
