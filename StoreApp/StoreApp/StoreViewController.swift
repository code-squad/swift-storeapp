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

    var storeItems = StoreItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setComplete(notification:)),
                                               name: .sectionSetComplete,
                                               object: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = rowHeightForCell
        StoreItems.categories.forEach { (category) in
            storeItems.set(with: category)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func resetTableView(indexPaths: [IndexPath]) {
        DispatchQueue.main.sync { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: indexPaths, with: .automatic)
            self?.tableView.endUpdates()
        }
    }

    @objc func setComplete(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let section = userInfo[Keyword.sectionPath] else { return }
        guard let sectionNumber = section as? [IndexPath] else { return }
        self.resetTableView(indexPaths: sectionNumber)
    }

}

extension StoreViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !self.storeItems.isEmpty() else { return UITableViewCell() }
        let itemCell = tableView.dequeueReusableCell(withIdentifier: Keyword.itemCell.rawValue, for: indexPath) as! StoreTableViewCell
        itemCell.itemData = storeItems[indexPath.section][indexPath.row]
        return itemCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !self.storeItems.isEmpty() else { return 0 }
        return self.storeItems[section].count()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard !self.storeItems.isEmpty() else { return 0 }
        return self.storeItems.countOfHeaders()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Toast(text: "\(storeItems[indexPath.section][indexPath.row].alt)\n\(storeItems[indexPath.section][indexPath.row].s_price)",
            duration: Delay.short).show()

    }

}

extension StoreViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: Keyword.customHeader.rawValue) as? HeaderView else { return nil }
        headerView.data = StoreItems.categories[section]
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return rowHeightForHeader
    }

}

