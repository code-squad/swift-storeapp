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
    var storeItems: StoreItems!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100.0
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
        let label = UILabel()
        label.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        label.text = " " + CATEGORIES[section].description.short
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }

}

