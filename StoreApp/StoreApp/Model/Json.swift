//
//  json.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit

struct StoreItem: Codable {
    let detailHash: String
    let image: String
    let alt: String
    var deliveryType: [String] = []
    let title: String
    let description: String
    let nPrice: String?
    let sPrice: String
    var badge: [String]? = []
    
    private enum CodingKeys: String, CodingKey {
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

func decode ()  -> [StoreItem]?{
    let decoder = JSONDecoder()
    guard let dataAsset = NSDataAsset(name: "main") else { return nil }
    do {
        return try decoder.decode([StoreItem].self, from: dataAsset.data)
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

