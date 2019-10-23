//
//  Model.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//
import UIKit

class Item: NSObject {
    var items : [StoreItem]?
    
    subscript(index: Int) -> StoreItem? {
        return items?[index]
    }
}


extension Item: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? MainTableViewCell, let reallyItem = items else { return UITableViewCell() }
        let data = reallyItem[indexPath.row]
        cell.configure(image: data.image, title: data.title, detail: data.description, nPrice: data.nPrice, sPrice: data.sPrice)
        return cell
    }
}
