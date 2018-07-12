//
//  ViewController.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit
import Toaster

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
  fileprivate let headerHeight = CGFloat(80)
  fileprivate var storeManager: StoreManager? {
    didSet {
      DispatchQueue.main.async {
        self.storeItemTableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    configueToastView()
  }
  
  fileprivate func setup() {
    storeItemTableView.register(StoreSectionHeader.self, forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
    
    storeItemTableView.register(StoreItemCell.self, forCellReuseIdentifier: cellIdentifier)
    
    NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView(notification:)), name: Notification.Name.storeList, object: nil)
    
    self.storeManager = StoreManager()
    self.storeManager?.generateData()
  }
  
  fileprivate func configueToastView() {
    let appearance = ToastView.appearance()
    appearance.backgroundColor = .mint
    appearance.textColor = .white
    appearance.font = UIFont.boldSystemFont(ofSize: 15)
    appearance.textInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    appearance.bottomOffsetPortrait = 350
    appearance.cornerRadius = 10
  }
  
  @objc fileprivate func refreshTableView(notification: Notification) {
    guard let userInfo = notification.userInfo, let list = userInfo[Constants.list] as? [StoreItems] else {
      return
    }
    
    self.storeManager = StoreManager(list: list)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let storeManager = self.storeManager else { return 0 }
    
    return storeManager.numberOfCells(section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StoreItemCell else {
      return UITableViewCell()
    }
    
    guard let storeManager = storeManager else { return UITableViewCell() }
    
    let item = storeManager[at: indexPath.section][at: indexPath.row]
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
    
    guard let storeManager = storeManager else { return UIView() }
    
    header.setContent(title: storeManager[at: section].title,
                      subtitle: storeManager[at: section].subtitle)
    
    return header
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    guard let storeManager = self.storeManager else { return 0 }
    
    return storeManager.numberOfSections
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return headerHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let storeManager = self.storeManager else { return }
    
    let item = storeManager[at: indexPath.section][at: indexPath.row]
    if let title = item.title, let salePrice = item.salePrice {
      Toast(text: "\(title) \(salePrice)").show()
    }
  }
}
