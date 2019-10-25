//
//  ViewController.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/21.
//  Copyright © 2019 hong3. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var ItemsTableVIew: UITableView!
    var items: [StoreItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = JsonHelper.loadItem()
        ItemsTableVIew.reloadData()
        // Do any additional setup after loading the view.
    }

}

extension ViewController{

}

extension ViewController: UITableViewDelegate{

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items else { return 0 }
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell,
            let items = self.items, items.count > indexPath.row else { return ItemCell() }
            cell.config(model: items[indexPath.row])
        return cell
    }
}


