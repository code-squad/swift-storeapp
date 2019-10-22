//
//  StoreItem.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

struct StoreItem: Decodable {
    // MARK: Constants
    struct Constants {
        static let jsonFileNames = ["main", "soup", "side"]
        static let headerInfo = [
            ["subTitle": "메인반찬", "title": "한그릇 뚝딱 메인 요리"],
            ["subTitle": "국.찌게", "title": "김이 모락모락 국.찌게"],
            ["subTitle": "밑반찬", "title": "언제 먹어도 든든한 밑반찬"]
        ]
    }

    // MARK: Properties
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

    // MARK: Functions
    static func getAllStoreItem() -> [[StoreItem]]? {
        return Constants.jsonFileNames.map { fileName in
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                debugPrint("json file is not exist")
                return []
            }

            guard let jsonData = try? Data(contentsOf: url) else {
                debugPrint("Fail to convert to jsondata")
                return []
            }

            guard let itemList = try? JSONDecoder().decode([StoreItem].self, from: jsonData) else {
                debugPrint("Fail to decode jsondata")
                return []
            }

            return itemList
        }
    }

}
