//
//  StoreItemService.swift
//  StoreApp
//
//  Created by 육지수 on 10/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

class StoreItemService {
    static let shared = StoreItemService()
    private init() {}

    func getStoreItemList(itemCategoryName: String) -> [StoreItem]? {
        guard let url = Bundle.main.url(forResource: itemCategoryName, withExtension: "json") else {
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
