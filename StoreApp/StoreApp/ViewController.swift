//
//  ViewController.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 21..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var storeItems = StoreItems(Keyword.file.name)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = tableView.dequeueReusableCell(withIdentifier: Keyword.customCell.name, for: indexPath) as? ItemCell else {
            return UITableViewCell()
        }
        itemCell.set(storeItems[indexPath.row])
        return itemCell
    }

}

