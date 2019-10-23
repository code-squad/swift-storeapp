//
//  StoreItemList.swift
//  StoreApp
//
//  Created by 육지수 on 10/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

struct StoreItemList {
    // MARK: Constants
    struct Constants {
        static let jsonFileNames = ["main", "soup", "side"]
        static let headerInfo = [
            ["subTitle": "메인반찬", "title": "한그릇 뚝딱 메인 요리"],
            ["subTitle": "국.찌게", "title": "김이 모락모락 국.찌게"],
            ["subTitle": "밑반찬", "title": "언제 먹어도 든든한 밑반찬"]
        ]
    }
    
    var items: [StoreItem]

    init?(itemCategoryName: String) {
        if let items = StoreItemService.shared.getStoreItemList(itemCategoryName: itemCategoryName) {
            self.items = items
        } else {
            return nil
        }
    }

    func getCount() -> Int {
        return self.items.count
    }

    func getStoreItem(_ index: Int) -> StoreItem {
        return self.items[index]
    }

}
