//
//  ViewController.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var storeItemTableView: UITableView! {
    didSet {
      self.storeItemTableView.delegate = self
      self.storeItemTableView.dataSource = self

    }
  }
  
  fileprivate let cellIdentifier = "StoreItemCell"
  fileprivate let sectionHeaderIdentifier = "StoreSectionHeader"
  fileprivate let rowHeight = CGFloat(100)
  fileprivate var storeItems: StoreItems? {
    didSet {
      DispatchQueue.main.async {
        self.storeItemTableView.reloadData()
      }
    }
  }
  
  let titles = ["A", "B", "C"]
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }
  
  fileprivate func setup() {
    storeItemTableView.register(StoreSectionHeader.self, forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
    
    storeItemTableView.register(StoreItemCell.self, forCellReuseIdentifier: cellIdentifier)
    
    NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView(notification:)), name: Notification.Name.storeItems, object: nil)
    
    self.storeItems = StoreItems()
    self.storeItems?.generateData()
  }
  
  @objc fileprivate func refreshTableView(notification: Notification) {
    guard let storeItems = notification.object as? StoreItems else {
      return
    }
    
    self.storeItems = storeItems
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let storeItems = self.storeItems else { return 0 }
    
    return storeItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StoreItemCell else {
      return UITableViewCell()
    }
    
    guard let storeItems = storeItems else { return UITableViewCell() }
    
    let item = storeItems[at: indexPath.row]
    cell.setItem(item)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderIdentifier) as? StoreSectionHeader else {
      return UIView()
    }
    
    header.setContents(title: "Title \(section)", subtitle: "Subtitle \(section)")
    
    return header
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 80
  }
}
