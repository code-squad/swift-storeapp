//
//  BadgeListViewDataSource.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/16.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class BadgeListViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    var badges: [String]? {
        didSet {
            dataDidUpdated?()
        }
    }
    
    // MARK: - Closures
    
    var dataDidUpdated: (() -> Void)?
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeListCell.reuseID, for: indexPath) as? BadgeListCell else {
            return .init()
        }
        let badge = badges?[indexPath.item]
        cell.configure(badge)
        return cell
    }
}
