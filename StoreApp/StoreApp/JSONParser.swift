//
//  JSONParser.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct JSONParser {
    static func getText(from url: String) -> String? {
        guard let url = URL(string: url) else { return nil }
        guard let textFromURL = try? String(contentsOf: url, encoding: .utf8) else { return nil }
        return textFromURL
    }
    
    static func parseJSONData() -> [StoreItem]? {
        guard let jsonData = getText(from: "http://public.codesquad.kr/jk/storeapp/main.json") else { return nil }
        let jsonDecoder = JSONDecoder()
        guard let data = jsonData.data(using: .utf8) else { return nil }
        return try? jsonDecoder.decode(Array<StoreItem>.self, from: data)
    }
}
