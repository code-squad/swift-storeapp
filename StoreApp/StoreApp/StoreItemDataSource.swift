//
//  StoreItemDataSource.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/17/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class StoreItemDataSource: NSObject, UITableViewDataSource {
    var storeItems = JsonReceiver.getJson()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeItemCell", for: indexPath) as! StoreItemTableViewCell
        
        cell.putInfo(storeItems[indexPath.row])
        
        return cell
    }
}
