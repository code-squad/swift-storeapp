//
//  ViewController.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let sections = [Keyword.Section.main, Keyword.Section.soup, Keyword.Section.side]
    private var storeItems = StoreItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        tableView.dataSource = self
        tableView.delegate = self
        storeItems.setHeaders(with: sections)
        tableView.reloadData()
        storeItems.setStoreData(with: sections)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func addNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(storeItemsHasChanged(notification:)),
            name: .storeItems,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showImage(notification:)),
            name: .image,
            object: nil
        )
    }

    @objc private func storeItemsHasChanged(notification: Notification) {
        self.tableView.beginUpdates()
        guard let userInfo = notification.userInfo as? [String: [IndexPath]] else { return }
        guard let indexPaths = userInfo["indexPaths"] else { return }
        self.tableView.insertRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
    }

    @objc private func showImage(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let row = userInfo["row"] as? Int else { return }
        guard let section = userInfo["section"] as? Int else { return }
        let indexPath = IndexPath.init(row: row, section: section)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count(of: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keyword.CellIdentifier.storeItem.value,
                                                       for: indexPath)
                        as? StoreItemTableViewCell else { return emptyCell }
        guard storeItems[indexPath.section].count != 0 else { return emptyCell }
        let storeItem = storeItems[indexPath.section][indexPath.row]
        cell.set(with: storeItem)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storeItem = storeItems[indexPath.section][indexPath.row]
        Toast(text: "\(storeItem.title) : \(storeItem.sPrice)").show()
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Keyword.Size.header.value)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: Keyword.CellIdentifier.header.value)
            as? HeaderTableViewCell else { return nil }
        let header = storeItems.sectionHeaders[section]
        headerView.titleLabel.text = header.title
        headerView.descriptionLabel.text = header.description
        return headerView
    }
}
