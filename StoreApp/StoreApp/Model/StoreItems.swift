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

    init(_ section : Section.Header) {
        guard let url = URL(string: section.url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.allItems = self.decode(data)
                NotificationCenter.default.post(name: .reloadItems, object: self, userInfo: [Keyword.Observer.sectionType.name: section])
            }
        }.resume()
    }
    
    init(fileName : String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: Keyword.fileType.name) else { return }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return }
        allItems = decode(data)
    }

    private func decode(_ data : Data) -> [Item] {
        do {
            return try JSONDecoder().decode([Item].self, from : data)
        } catch {
            return []
        }
    }
    
}
