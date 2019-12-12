//
//  StoreTableViewManager.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/13.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

// MARK: - StoreTableViewManager

class StoreTableViewManager: NSObject {
    
    weak var stores: StoreListViewDataSource?
}

// MARK: - UITableViewDataSource

extension StoreTableViewManager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stores?.numOfCategories() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores?.numOfMenusInCategory(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(with: MenuCell.self, for: indexPath),
            let menu = stores?[menu: indexPath]
            else { return .init() }
        
        cell.configure(menu)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StoreTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let categoryHeader = tableView.dequeueReusableHeaderFooterView(with: CategoryHeaderView.self),
            let category = stores?[category: section]
            else { return nil }
        
        categoryHeader.configure(category: category)
        return categoryHeader
    }
}
