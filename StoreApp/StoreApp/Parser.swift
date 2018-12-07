//
//  Parser.swift
//  StoreApp
//
//  Created by oingbong on 07/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct Parser {
    static func json(fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            return jsonData
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func storeItems(from data: Data) -> [StoreItem]? {
        do {
            let items = try JSONDecoder().decode([StoreItem].self, from: data)
            for item in items {
                print(item)
            }
            return items
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
