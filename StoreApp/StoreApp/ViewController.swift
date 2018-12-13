//
//  ViewController.swift
//  StoreApp
//
//  Created by oingbong on 06/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var store = Store()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Key.storeItemCell, for: indexPath) as! StoreItemCell
        let items = store[indexPath.section].sectionObjects[indexPath.row]
        cell.configure(from: items)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ToastCenter.default.cancelAll()
        let item = store[indexPath.section].sectionObjects[indexPath.row]
        Toast(text: "\(item.title) \(item.s_price)").show()
    }
}

// for Section
extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.storeItemGroupCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return store[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Key.storeHeaderCell) as! StoreHeaderCell
        cell.configure(from: store[section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ViewController {
    private func configureObservers() {
        let key = Notification.Name(Key.notification)
        NotificationCenter.default.addObserver(self, selector: #selector(updateItems), name: key, object: nil)
    }
    
    @objc private func updateItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
