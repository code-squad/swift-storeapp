//
//  DataManager.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct DataManager {
    
    private static func decode<Model: Decodable>(data: Data, type: Model.Type) -> Model? {
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(type, from: data) else { return nil }
        return decoded
    }
    
    private static func readDataFromJSON(fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        let fileUrl = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: fileUrl) else { return nil }
        return data
    }
    
    static func readStoreItemsFromJSON<Model: Decodable>(fileName: String, _ type: Model.Type) -> Model? {
        guard let data = self.readDataFromJSON(fileName: fileName) else { return nil }
        let storeItems = self.decode(data: data, type: type)
        return storeItems
    }
    
    static func fetchStoreItemsFromStoreAPI(_ foodCategory: FoodCategory, completionHandler: @escaping ([StoreItem]) -> Void) {
        StoreAPI.fetchStoreItems(foodCategory) { (data, error) in
            if error != nil {
                guard let storeItems = readStoreItemsFromJSON(fileName: foodCategory.rawValue, [StoreItem].self) else { return }
                completionHandler(storeItems)
            }
            guard let data = data, let storeItems = decode(data: data, type: [StoreItem].self) else { return }
            completionHandler(storeItems)
        }
    }
}
