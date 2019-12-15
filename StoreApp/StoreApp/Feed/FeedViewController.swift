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
    var dataSource = FeedViewDataSource()
    
    // MARK: - Outlets
    
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttributes()
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
        
        feedTableView.dataSource = dataSource
        feedTableView.delegate = self
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
