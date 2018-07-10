//
//  ViewController.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var storeItemTableView: UITableView!
  
  fileprivate let cellIndentifier = "StoreItemCell"
  fileprivate let cellHeight = CGFloat(100)
  fileprivate var storeItems: StoreItems? {
    didSet {
      DispatchQueue.main.async {
        self.storeItemTableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.storeItemTableView.delegate = self
    self.storeItemTableView.dataSource = self
    
    setup()
  }
  
  fileprivate func setup() {
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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let storeItems = self.storeItems else { return 0 }
    
    return storeItems.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? StoreItemCell else {
      return UITableViewCell()
    }
    
    guard let storeItems = storeItems else { return UITableViewCell() }
    
    let item = storeItems[at: indexPath.row]
    cell.setItem(item)
    
    return cell
  }
}
