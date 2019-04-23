//
//  StorePresenter.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 19..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class StorePresenter: NSObject {

    private let storeItems = StoreItemManager()
    
}

extension StorePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems[section]?.count() ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storeItems.itemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableViewCell.identifier,
                                                 for: indexPath)
        guard let storeTableViewCell = cell as? StoreTableViewCell,
            let storeItems = storeItems[indexPath.section],
            let storeItem = storeItems[indexPath.row] else { return cell }
        
        storeTableViewCell.show(with: storeItem)
        return storeTableViewCell
    }
}

extension StorePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: StoreTableViewHeaderView.identifier)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
