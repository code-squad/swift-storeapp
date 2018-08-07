//
//  ViewController.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 26..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit
import Toaster
import Alamofire

class StoreViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let rowHeightForCell: CGFloat = 100
    let rowHeightForHeader: CGFloat = 60

    var storeItems = StoreItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(dataReload), name: .reachabilityChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setComplete(notification:)),name: .sectionSetComplete,object: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = rowHeightForCell
        StoreItems.categories.forEach { (category) in
            self.storeItems.set(with: category)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func dataReload() {
        StoreItems.categories.forEach { (category) in
            self.storeItems.set(with: category)
        }
    }

    private func resetTableView(of header: Category) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer:header.sectionNumber), with: .automatic)
        }
    }

    @objc func setComplete(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let section = userInfo[Keyword.sectionPath] else { return }
        guard let category = section as? Category else { return }
        self.resetTableView(of: category)
    }

    private func toUnreachableView() {
        if let unreachableVC = self.storyboard?.instantiateViewController(withIdentifier: "unreachableViewController") as? UnreachableViewController {
            self.navigationController?.pushViewController(unreachableVC, animated: true)
        }
    }

    private func runToast(indexPath: IndexPath) {
        Toast(text: "\(storeItems[indexPath.section][indexPath.row].alt)\n\(storeItems[indexPath.section][indexPath.row].s_price)",
            duration: Delay.short).show()
    }
}

extension StoreViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: Keyword.itemCell.rawValue, for: indexPath) as! StoreTableViewCell
        itemCell.itemData = storeItems[indexPath.section][indexPath.row]
        return itemCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeItems[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.storeItems.countOfHeaders()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "itemDetailView") as? ItemViewController {
            if let selectedCell = tableView.cellForRow(at: indexPath) as? StoreTableViewCell {
                if selectedCell.isHashDataEnable {
                    self.runToast(indexPath: indexPath)
                    nextVC.itemData = selectedCell.detailHash
                    self.navigationController?.pushViewController(nextVC, animated: true)
                } else {
                    self.toUnreachableView()
                }
            }
        }
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

