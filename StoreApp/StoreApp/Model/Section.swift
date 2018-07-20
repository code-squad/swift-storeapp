//
//  Section.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol SectionData {
    var itemSet: StoreItems { get }
    init(category: Category)
    func setItems(_ items: [Category: Items])
    func category() -> Category
}

class Section: SectionData {

    var itemSet = StoreItems()

    required init(category: Category) {
        URLSession.shared.dataTask(with: category.url) { [self, category] (data, response, error) in
            if let error = error {
                print("DataTask error: \(error)\n")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                let items = ItemDataParser.makeStoreItemsFromSession(category: category, data: data)
                self.setItems(items)
            } else {
                print("DataTask error: response \n")
                return
            }
        }.resume()
    }

    func setItems(_ items: [Category: Items]) {
        self.itemSet = StoreItems(data: items)
        NotificationCenter.default.post(name: .sectionSetComplete, object: self, userInfo: ["sectionData":self])
    }

    func category() -> Category {
        return self.itemSet.category()
    }


}
