//
//  ViewController.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 26..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit
import Toaster

class StoreViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let rowHeightForCell: CGFloat = 100
    let rowHeightForHeader: CGFloat = 60

    var storeItems: StoreItems!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = rowHeightForCell
        self.storeItems = StoreItems()
        tableView.register(UINib(nibName: Keyword.HeaderView.rawValue,
                                 bundle: nil),
                           forHeaderFooterViewReuseIdentifier: Keyword.headerView.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension StoreViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: Keyword.itemCell.rawValue, for: indexPath) as! StoreTableViewCell
        itemCell.itemData = storeItems[indexPath.section][indexPath.row]
        return itemCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems[section].count()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return StoreItems.categories.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Toast(text: "\(storeItems[indexPath.section][indexPath.row].alt)\n\(storeItems[indexPath.section][indexPath.row].s_price)",
            duration: Delay.long).show()
    }

}

extension StoreViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Keyword.headerView.rawValue) as? HeaderView else { return nil }
        headerView.data = StoreItems.categories[section]
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return rowHeightForHeader
    }

}

