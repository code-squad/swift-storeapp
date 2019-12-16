//
//  FeedViewPresenter.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/10.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class FeedViewPresenter: NSObject {

    // MARK: - Properties
    
    private var feedProvider: FeedDataProvider
    private var feedSections: [FeedSection] = []
    
    init(feedDataProvider: FeedDataProvider) {
        self.feedProvider = feedDataProvider
    }
    
    func fetchFeed() {
        feedProvider.request(assets: StoreItemCategory.allCases) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let sections):
                strongSelf.feedSections = sections
                NotificationCenter.default.post(name: FeedEvent.itemDidUpdated.name, object: nil)
            case .failure(let error):
                print(error.message)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension FeedViewPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedSections[section].storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedListCell.reuseID, for: indexPath) as? FeedListCell else {
            return .init()
        }
        let storeItems = feedSections[indexPath.section].storeItems
        let storeItem = storeItems[indexPath.row]
        cell.configure(storeItem)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FeedViewPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FeedCategoryHeaderView.reuseID) as? FeedCategoryHeaderView else {
            return .init()
        }
        let category = feedSections[section].category
        headerView.configure(category)
        return headerView
    }
}
