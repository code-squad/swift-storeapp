//
//  FeedCategoryHeaderView.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class FeedCategoryHeaderView: UITableViewHeaderFooterView {

    // MARK: - Outlets
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpAttributes()
    }
}

// MARK: - Attributes

extension FeedCategoryHeaderView {
    private func setUpAttributes() {
        setUpLabels()
    }
    
    private func setUpLabels() {
        categoryLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        categoryLabel.textColor = .lightGray
        categoryLabel.textAlignment = .center
        categoryLabel.layer.borderColor = UIColor.lightGray.cgColor
        categoryLabel.layer.borderWidth = 1.0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
    }
}

// MARK: - Configures

extension FeedCategoryHeaderView {
    func configure(_ category: StoreItemCategory) {
        categoryLabel.text = category.titleText
        descriptionLabel.text = category.descriptionText
    }
}
