//
//  StoreItem.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 13..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

class StoreItems {
    
    private var storeItems = [StoreItem]()
    
    var itemCount: Int {
        return storeItems.count
    }

    subscript(index: Int) -> StoreItem {
        return storeItems[index]
    }
    
    init(url: String) {
        guard let path = URL(string: url) else { return }
        URLSession.shared.dataTask(with: path) {(data, response, error) in
            guard let data = data else { return }
            self.storeItems = self.jsonDecode(data)
        }.resume()
    }
    
    func jsonDecode(_ data: Data) -> [StoreItem] {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([StoreItem].self, from: data)
        } catch  {
            return []
        }
    }
    
}

struct StoreItem: Decodable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [String]
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    let badge: [String]?
    
    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image
        case alt
        case deliveryType = "delivery_type"
        case title
        case description
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge
    }
}


