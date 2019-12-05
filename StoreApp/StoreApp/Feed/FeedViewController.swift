//
//  FeedViewController.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: - Properties
    
    var storeItems: [StoreItem] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttributes()
        decodeJSON()
    }

    
    private func decodeJSON() {
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "main") else { return }
        do {
            storeItems = try jsonDecoder.decode([StoreItem].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

// MARK: - Attributes

extension FeedViewController {
    private func setUpAttributes() {
        setUpTableView()
    }
    
    private func setUpTableView() {
        let categoryHeaderView = UINib(nibName: FeedCategoryHeaderView.reuseID, bundle: nil)
        feedTableView.register(categoryHeaderView, forHeaderFooterViewReuseIdentifier: FeedCategoryHeaderView.reuseID)
        
        let feedCell = UINib(nibName: FeedListCell.reuseID, bundle: nil)
        feedTableView.register(feedCell, forCellReuseIdentifier: FeedListCell.reuseID)
        
        feedTableView.separatorStyle = .none
        feedTableView.sectionHeaderHeight = UITableView.automaticDimension
        feedTableView.estimatedSectionHeaderHeight = 80.0
        feedTableView.showsVerticalScrollIndicator = false
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedListCell.reuseID, for: indexPath) as? FeedListCell else {
            return .init()
        }
        let storeItem = storeItems[indexPath.row]
        cell.configure(storeItem)
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FeedCategoryHeaderView.reuseID) as? FeedCategoryHeaderView else {
            return .init()
        }
        
        return headerView
    }
}
