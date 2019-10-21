//
//  StoreItem.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    var detailHash: String
    var image: String
    var alt: String
    var deliveryType: [String]
    var title: String
    var description: String
    var sPrice: String
    var nPrice: String?
    var badge: [String]?

    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case deliveryType = "delivery_type"
        case nPrice = "n_price"
        case sPrice = "s_price"
        case image, alt, title, description, badge
    }

    static func getAllStoreItem() -> [StoreItem]? {
        guard let url = Bundle.main.url(forResource: "main", withExtension: "json") else {
            debugPrint("json file is not exist")
            return nil
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            debugPrint("Fail to convert to jsondata")
            return nil
        }

        guard let itemList = try? JSONDecoder().decode([StoreItem].self, from: jsonData) else {
            debugPrint("Fail to decode jsondata")
            return nil
        }

        return itemList
    }

}
