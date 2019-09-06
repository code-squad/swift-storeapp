//
//  JsonReceiver.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/6/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import Foundation

struct JsonReceiver {
    static func getJson() -> StoreItems {
        var storeItems = StoreItems()
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: URLString.StoreItem.rawValue) else {
            return storeItems
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("load data failed")
                return
            }
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                storeItems =  try decoder.decode(StoreItems.self, from: data)
                semaphore.signal()
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
        semaphore.wait()
        
        return storeItems
    }
}

