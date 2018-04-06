//
//  ViewController.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    private var storeItems = StoreItems()

    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        setStore()
    }

    private func setStore() {
        let files = [Keyword.mainFile.value, Keyword.soupFile.value, Keyword.sideFile.value]
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
            self.tableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return storeItems.sectionHeaders.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return storeItems.sectionHeaders[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count(of: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keyword.customCellName.value, for: indexPath)
            as? StoreItemTableViewCell else { return UITableViewCell() }
        let storeItem = storeItems[indexPath.section][indexPath.row]
        cell.set(with: storeItem)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

