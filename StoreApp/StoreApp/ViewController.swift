//
//  ViewController.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var storeTableView: UITableView!
    private let storeItemCellIdentifier = "storeItemCell"
    private let customHeaderViewReuseId = "customHeaderView"
    private var sectionInfo: SectionInfo!
    
    private func configureNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didStoreItemsSet(_:)), name: .didStoreItemsSet, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: customHeaderViewReuseId)
        configureNotificationObserver()
        self.sectionInfo = SectionInfo(categories: FoodCategory.allCases)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func didStoreItemsSet(_ notification: Notification) {
        guard let sectionInfo = notification.userInfo?[StoreItemList.notificationInfoKey] as? FoodCategory else { return }
        guard let sectionIndex: Int = FoodCategory.allCases.firstIndex(of: sectionInfo) else { return }
        DispatchQueue.main.sync { [unowned self] in
            self.storeTableView.reloadSections(IndexSet(integer: sectionIndex), with: .automatic)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeItem = sectionInfo[indexPath.section][indexPath.row]
        guard let storeCell = tableView.dequeueReusableCell(withIdentifier: storeItemCellIdentifier, for: indexPath) as? StoreItemTableViewCell else {
            return UITableViewCell()
        }
        storeCell.setLabel(with: storeItem)
        storeCell.setThumbnailImage(with: storeItem)
        return storeCell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: customHeaderViewReuseId) as? SectionHeaderView else {
            return nil
        }
        headerView.setLabel(with: sectionInfo[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storeItem = sectionInfo[indexPath.section][indexPath.row]
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
        detailVC.setDetailHash(title: storeItem.title, detailHash: storeItem.detailHash)
        detailVC.delegate = self
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func showItemOnToast(title: String, price: String) {
        ToastCenter.default.cancelAll()
        Toast(text: "\(title) \(price)").show()
    }
}

extension ViewController: DetailViewControllerDelegate {
    func showToast(menu: String, price: String) {
        showItemOnToast(title: menu, price: price)
    }
}
