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
    lazy var imageDownloadSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "imageDownloadSessionConfig")
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    private func configureNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didStoreItemsSet(_:)), name: .didStoreItemsSet, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeTableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: customHeaderViewReuseId)
        configureNotificationObserver()
        self.sectionInfo = SectionInfo(categories: FoodCategory.allCases)
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
        DispatchQueue.main.async {
            storeCell.setThumbnailImage(with: storeItem)
        }
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
        tableView.deselectRow(at: indexPath, animated: true)
        ToastCenter.default.cancelAll()
        let storeItem = sectionInfo[indexPath.section][indexPath.row]
        Toast(text: "\(storeItem.title) \(storeItem.salePrice)").show()
    }
}

extension ViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print(location)
    }
}
