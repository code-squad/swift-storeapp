//
//  StoreItems.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 26..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

class StoreItems {
    
    private var allItems = [Item]()
    var count : Int {
        return allItems.count
    }
    
    subscript(index : Int) -> Item {
        return allItems[index]
    }
    
    init(_ urlString : String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            self.allItems = self.decode(data)
            NotificationCenter.default.post(name: .reloadItems, object: self)
        }.resume()
    }
    
    private func decode(_ data : Data) -> [Item] {
        do {
            return try JSONDecoder().decode([Item].self, from : data)
        } catch {
            return []
        }
    }
    
}
