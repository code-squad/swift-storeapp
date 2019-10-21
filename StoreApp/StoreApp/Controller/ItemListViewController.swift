//
//  ItemListViewController.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Outlets
    var itemList = [StoreItem]()

    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTebleView()
        setupItemData()
    }

    // MARK: Functions
    func setupTebleView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func setupItemData() {
        guard let url = Bundle.main.url(forResource: "main", withExtension: "json") else {
            debugPrint("json file is not exist")
            return
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            debugPrint("Fail to convert to jsondata")
            return
        }

        if let itemList = try? JSONDecoder().decode([StoreItem].self, from: jsonData) {
            self.itemList = itemList
        }
    }

}

// MARK: UITableViewDataSource Extension
extension ItemListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = tableView.dequeueReusableCell(withIdentifier: "StoreItemCell", for: indexPath) as? StoreItemCell else {
            return UITableViewCell()
        }

        let item = self.itemList[indexPath.row]
        itemCell.configure(with: item)
        return itemCell
    }

}

// MARK: UITableViewDelegate Extension
extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "ItemHeaderCell") as? ItemHeaderCell
        return header ?? nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ItemHeaderCell.height
    }
}
