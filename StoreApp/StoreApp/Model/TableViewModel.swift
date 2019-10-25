//
//  TableViewModel.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/23.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class TableViewModel: NSObject, UITableViewDataSource {
    
    var storeItemsArray = Array<Array<StoreItem>>()
    
    func itemOf(section: Int, row: Int) -> StoreItem {
        return storeItemsArray[section][row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storeItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItemsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! StoreItemCell
        cell.item = storeItemsArray[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
