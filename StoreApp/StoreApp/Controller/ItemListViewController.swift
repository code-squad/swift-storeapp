//
//  ItemListViewController.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import Toaster

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
        guard let header = tableView.dequeueReusableCell(withIdentifier: "ItemHeaderCell") as? ItemHeaderCell else {
            debugPrint("Fail: convert to ItemHeaderCell")
            return nil
        }

        let headerInfo = StoreItemList.Constants.headerInfo[section]
        if let title = headerInfo[ItemHeaderCell.Constant.title], let subTitle = headerInfo[ItemHeaderCell.Constant.subTitle] {
            header.configure(title: title, subTitle: subTitle)
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ItemHeaderCell.Constant.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.itemListTableViewModel.getItem(in: indexPath.section, row: indexPath.row)
        Toast(text: "\(item.title) \(item.sPrice)").show()
    }
}
