//
//  ItemListTableViewModel.swift
//  StoreApp
//
//  Created by 육지수 on 10/22/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class ItemListTableViewModel: NSObject, UITableViewDataSource {
    var itemList = [StoreItemList]()

    override init() {
        let itemList = StoreItemList.Constants.jsonFileNames.compactMap({ StoreItemList(itemCategoryName: $0) })
        self.itemList = itemList

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList[section].getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = tableView.dequeueReusableCell(withIdentifier: "StoreItemCell", for: indexPath) as? StoreItemCell else {
            return UITableViewCell()
        }

        let item = self.itemList[indexPath.section].getStoreItem(indexPath.row)
        itemCell.configure(with: item)
        return itemCell
    }

    func getItem(in section: Int, row: Int) -> StoreItem {
        return self.itemList[section].getStoreItem(row)
    }
}
