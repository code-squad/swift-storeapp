//
//  StorePresenter.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 19..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit
import Toaster

class StorePresenter: NSObject {

    //MARK: - Properties
    //MARK: Views
    private weak var storeTableViewController: StoreTableViewController?
    
    //MARK: Models
    private let storeItems: StoreItemManager
    
    //MARK: - Methods
    //MARK: Initialization
    override init() {
        let variousSectionInfo = [SectionInfo(fileName: "main", title: "메인반찬", description: "한그릇 뚝딱 메인 요리"),
                                  SectionInfo(fileName: "soup", title: "국.찌게", description: "김이 모락모락 국.찌게"),
                                  SectionInfo(fileName: "side", title: "밑반찬", description: "언제 먹어도 든든한 밑반찬"),]
        self.storeItems = StoreItemManager(variousSectionInfo: variousSectionInfo)
        super.init()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableSection),
                                               name: .storeItemsDidUpdate,
                                               object: nil)
    }
    
    //MARK: Objc
    @objc func reloadTableSection(_ noti: Notification) {
        guard let object = noti.object as? StoreItems,
            let index = storeItems.index(of: object) else { return }
        storeTableViewController?.reload(section: index)
    }
    
    //MARK: Presenter
    func attach(storeTableViewCotroller: StoreTableViewController) {
        self.storeTableViewController = storeTableViewCotroller
    }
    
    func detachStoreTableView() {
        self.storeTableViewController = nil
    }
}

extension StorePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems[section]?.count() ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storeItems.itemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableViewCell.identifier,
                                                 for: indexPath)
        guard let storeTableViewCell = cell as? StoreTableViewCell,
            let storeItems = storeItems[indexPath.section],
            let storeItem = storeItems[indexPath.row] else { return cell }
        
        storeTableViewCell.show(with: storeItem)
        return storeTableViewCell
    }
}

extension StorePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: StoreTableViewHeaderView.identifier)
        guard let sectionInfo = storeItems[section]?.sectionInfo,
            let storeTableViewHeaderView = cell as? StoreTableViewHeaderView else { return nil }
        storeTableViewHeaderView.show(with: sectionInfo)
        return storeTableViewHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = storeItems[indexPath.section],
            let item = items[indexPath.row] else { return }
        if let toast = ToastCenter.default.currentToast {
            toast.cancel()
        }
        Toast(text: "타이틀 메뉴: \(item.title)\n가격: \(item.s_price)",
              delay: 0,
              duration: Delay.short).show()
    }
}
