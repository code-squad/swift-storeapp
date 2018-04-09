//
//  ViewController.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    private var storeItems = StoreItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        setStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setStore() {
        let files = [Keyword.File.main, Keyword.File.soup, Keyword.File.side]
        storeItems.setStoreData(with: files)
    }

    private func addNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(storeItemsSetted(notification:)),
            name: .storeItems,
            object: nil
        )
    }

    @objc private func storeItemsSetted(notification: Notification) {
        guard let storeItems = notification.object as? StoreItems else { return }
        self.storeItems = storeItems
        DispatchQueue.main.async {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
        }
    }

    // MARK: UITableViewDelegate
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

    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return storeItems.sectionHeaders.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count(of: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keyword.CellIdentifier.storeItem.value, for: indexPath)
            as? StoreItemTableViewCell else { return UITableViewCell() }
        let storeItem = storeItems[indexPath.section][indexPath.row]
        cell.set(with: storeItem)
        return cell
    }

}

