//
//  DataSourceObject.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class DataSourceObject : NSObject, UITableViewDataSource {
    private let defaultCellIdentifier : String = "CustomCell"
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath) as! CustomCell
        
        
        let storeItem = storeItems[indexPath.row]
        
        cell.title.text = storeItem.title
        cell.itemDescription.text  = storeItem.description
        cell.s_price.text  = storeItem.s_price
        cell.delivery_type.text = {
            var result = ""
            for text in storeItem.delivery_type {
                result.append(text)
                result += ","
            }
            result.removeLast()
            return result
        }()
            
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
