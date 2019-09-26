//
//  StoreItemDataSource.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/17/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class StoreItemDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var storeItems = [StoreItem]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let urlString = URLString(call: section)
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
        cell.putInfo(title: urlString.getHeaderTitle(), description: urlString.getHeaderDescription())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let urlString = URLString(call: section)
        storeItems = JSONReceiver.getJson(urlString: urlString)
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeItemCell", for: indexPath) as! StoreItemTableViewCell
        
        cell.putInfo(storeItems[indexPath.row])
        
        return cell
    }
}
