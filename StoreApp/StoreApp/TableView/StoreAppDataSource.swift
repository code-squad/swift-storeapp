//
//  StoreAppDataSource.swift
//  StoreApp
//
//  Created by 윤동민 on 11/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class StoreAppDataSource: NSObject, UITableViewDataSource {
    private var storeItems: StoreItems = StoreItems()

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.countItems(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoreItemCell.identifier, for: indexPath) as? StoreItemCell else { return UITableViewCell() }
        storeItems.access(of: indexPath.section, at: indexPath.row) { item in
            let itemDTO = item.getDTO()
            cell.set(itemDTO)
        }
        return cell
    }
}
