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
    let itemListTableViewModel = ItemListTableViewModel()

    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTebleView()
    }

    // MARK: Functions
    func setupTebleView() {
        self.tableView.dataSource = itemListTableViewModel
        self.tableView.delegate = self
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
