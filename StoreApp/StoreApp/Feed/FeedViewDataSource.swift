//
//  FeedViewDataSource.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/10.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class FeedViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var storeItems: [StoreItem] = [] {
        didSet {
            NotificationCenter.default.post(name: FeedEvent.itemDidUpdated.name, object: nil)
        }
    }
    
    override init() {
        super.init()
        
        decodeJSON()
    }
    
    // MARK: - UITableViewDataSource
    
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

extension FeedViewDataSource {
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
