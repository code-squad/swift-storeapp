//
//  ViewController.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 26..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! StoreTableViewCell
        itemCell.itemData = storeItems[indexPath.section][indexPath.row]
        return itemCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems[section].count()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return CATEGORIES.count
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView else { return nil }
        headerView.data = CATEGORIES[section]
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return rowHeightForHeader
    }

}

