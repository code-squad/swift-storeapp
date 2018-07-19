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
  fileprivate let detailViewControllerIdentifier = "DetailViewController"
  fileprivate let rowHeight = CGFloat(100)
  fileprivate let headerHeight = CGFloat(80)
  fileprivate var storeDataManager: StoreDataManager? {
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
    
    self.storeDataManager = StoreDataManager()
    self.storeDataManager?.generateData()
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
    guard let userInfo = notification.userInfo,
      let list = userInfo[Constants.list] as? [StoreItems] else { return }
    
    self.storeDataManager = StoreDataManager(list: list)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let storeManager = self.storeDataManager else { return 0 }
    
    return storeManager.numberOfCells(section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StoreItemCell else {
      return UITableViewCell()
    }
    
    guard let storeManager = storeDataManager else { return UITableViewCell() }
    
    let item = storeManager[at: indexPath.section][at: indexPath.row]
    cell.setItem(item)
    
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    guard let storeManager = self.storeDataManager else { return 0 }
    
    return storeManager.numberOfSections
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rowHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderIdentifier) as? StoreSectionHeader else {
      return UIView()
    }
    
    guard let storeManager = storeDataManager else { return UIView() }
    
    header.setContent(title: storeManager[at: section].title,
                      subtitle: storeManager[at: section].subtitle)
    
    return header
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return headerHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let storeManager = self.storeDataManager else { return }
    
    let item = storeManager[at: indexPath.section][at: indexPath.row]
    if let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: detailViewControllerIdentifier) as? DetailViewController {
      detailViewController.itemDetail = StoreDetailItem(item.title, item.detailHash)
      detailViewController.orderDelegate = self
      self.navigationController?.pushViewController(detailViewController, animated: true)
    }
  }
}

extension ViewController: OrderDelegate {
  func showResult(_ orderInfo: OrderInfo) {
    Toast(text: orderInfo.description).show()
  }
}
