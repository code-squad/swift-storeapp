//
//  DataSetter.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 24..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol URLDataProtocol {
    var url: URL { get }
}

class DataSetter<T: URLDataProtocol> {
    typealias T = Category

    class func set(with category: T, handler: @escaping(([Category:Items]) -> Void)) {
        URLSession.shared.dataTask(with: category.url) { [category] (data, response, error) in
            if let error = error {
                print("Network error: \(error) \n")
                let result = ItemDataParser.makeStoreItemsFromJSON(with: category)
                handler(result)
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                let result = ItemDataParser.makeStoreItemsFromSession(category: category, data: data)
                handler(result)
            } else {
                print("DataTask error: response \n")
                let result = ItemDataParser.makeStoreItemsFromJSON(with: category)
                handler(result)
            }
        }.resume()
    }
}
