//
//  DataManager.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct DataManager {
    
    static func decode<Model: Decodable>(data: Data, type: Model.Type) -> Model? {
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(type, from: data) else { return nil }
        return decoded
    }
    
    static func readDataFromJSON(fileName: String) -> Data? {
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
    
    static func fetchStoreItemsFromStoreAPI(_ foodCategory: FoodCategory, _ completion: @escaping ([StoreItem]) -> Void) {
        guard let url = StoreAPI.storeURL(category: foodCategory) else { return }
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            // Error발생 시 파일에서 데이터를 읽음.
            if let _ = error {
                if let storeItems = readStoreItemsFromJSON(fileName: foodCategory.rawValue, [StoreItem].self) {
                    completion(storeItems)
                }
                return
            }
            guard let data = data else { return }
            guard let storeItems = DataManager.decode(data: data, type: [StoreItem].self) else { return }
            completion(storeItems)
        }
        task.resume()
    }
}
