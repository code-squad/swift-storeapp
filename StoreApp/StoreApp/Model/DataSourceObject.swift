//
//  DataSourceObject.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 25..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class DataSourceObject : NSObject, UITableViewDataSource {
    private let defaultCellIdentifier : String = "defaultCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = MyCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: self.defaultCellIdentifier)
        
        cell.textLabel?.text = friends[indexPath.row].name
        cell.detailTextLabel?.text = "나이 : \(friends[indexPath.row].age)  전화번호 : \(friends[indexPath.row].mobileNumber)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
