//
//  TableData.swift
//  StoreApp
//
//  Created by Summer on 23/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import Foundation
import UIKit

class MenuDataSource : NSObject, UITableViewDataSource {
    var menuList = Array<MenuItem>()
    override init(){
        super.init()
        ["main", "soup", "side"].forEach{ v in
            self.loadData(fileName: v)
        }
    }
    private func loadData(fileName:String){
        let url = Bundle.main.url(forResource: fileName, withExtension: "json", subdirectory: "json")!
        let jsonData = try? Data.init(contentsOf: url)
        let decoder = JSONDecoder()
        menuList.append(try! decoder.decode(MenuItem.self, from : jsonData!))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.setData(item: menuList[indexPath.section][indexPath.row]!)
        return cell
    }
}
