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
    
    var presenter: FeedViewPresenter? {
        didSet {
            loadViewIfNeeded()
            presenter?.fetchFeed()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        setUpAttributes()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: FeedEvent.itemDidUpdated.name,
                                               object: nil)
    }
    
    // MARK: - Events
    
    @objc private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.feedTableView.reloadData()
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
        feedTableView.estimatedSectionHeaderHeight = 70.0
        feedTableView.showsVerticalScrollIndicator = false
        
        feedTableView.dataSource = presenter
        feedTableView.delegate = presenter
    }
}
