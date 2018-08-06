//
//  DataSetter.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 24..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class DataSetter {

    class func tryDownload(url: Category, handler: @escaping (([Category:Items]) -> Void)) {
        if NetworkManager.shared.reachable {
            DataSetter.set(with: url, handler: handler)
        } else {
            let result = ItemDataParser.makeStoreItemsFromJSON(with: url)
            handler(result)
        }
    }

    private class func set(with category: Category, handler: @escaping(([Category:Items]) -> Void)) {
        URLSession.shared.dataTask(with: category.url) { [category] (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                let result = ItemDataParser.makeStoreItemsFromSession(category: category, data: data)
                handler(result)
            } else {
                let result = ItemDataParser.makeStoreItemsFromJSON(with: category)
                handler(result)
            }
        }.resume()
    }
}
