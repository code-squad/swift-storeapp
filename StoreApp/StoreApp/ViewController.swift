//
//  ViewController.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController {
    
    @IBOutlet weak var storeTableView: UITableView!
    private let storeItemCellIdentifier = "storeItemCell"
    private let customHeaderViewReuseId = "customHeaderView"
    private var sectionInfo: SectionInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionInfo = SectionInfo(categories: FoodCategory.allCases)
        storeTableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: customHeaderViewReuseId)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeItem = sectionInfo[indexPath.section][indexPath.row]
        guard let storeCell = tableView.dequeueReusableCell(withIdentifier: storeItemCellIdentifier, for: indexPath) as? StoreItemTableViewCell else {
            return UITableViewCell()
        }
        storeCell.setLabel(with: storeItem)
        return storeCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: customHeaderViewReuseId) as? SectionHeaderView else {
            return nil
        }
        headerView.setLabel(with: sectionInfo[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        ToastCenter.default.cancelAll()
        let storeItem = sectionInfo[indexPath.section][indexPath.row]
        Toast(text: "\(storeItem.title) \(storeItem.salePrice)").show()
    }
}
