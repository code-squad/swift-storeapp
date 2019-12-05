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
        let feedCell = UINib(nibName: FeedListCell.reuseID, bundle: nil)
        feedTableView.register(feedCell, forCellReuseIdentifier: FeedListCell.reuseID)
        
        feedTableView.dataSource = self
        feedTableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedListCell.reuseID, for: indexPath) as? FeedListCell else {
            return .init()
        }
        return cell
    }
}
