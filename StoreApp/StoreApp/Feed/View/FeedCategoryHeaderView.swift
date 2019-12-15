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
    
    @IBOutlet weak var titleLabel: UILabel!
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
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        titleLabel.layer.borderWidth = 1.0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
    }
}

// MARK: - Configures

extension FeedCategoryHeaderView {
    func configure(_ category: StoreItemCategory) {
        titleLabel.text = category.titleText
        descriptionLabel.text = category.descriptionText
    }
}
