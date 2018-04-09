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

    private func setStore() {
        let files = [Keyword.mainFile, Keyword.soupFile, Keyword.sideFile]
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return storeItems.sectionHeaders.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(60)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: "header")
                                as? HeaderTableViewCell else { return nil }
        let header = storeItems.sectionHeaders[section].split(separator: "/").map {
            String($0.trimmingCharacters(in: [" "]))
        }
        headerView.titleLabel.text = header[0]
        headerView.descriptionLabel.text = header[1]
        return headerView
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

