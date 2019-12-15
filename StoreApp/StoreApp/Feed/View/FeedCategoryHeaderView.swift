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
    
    @IBOutlet weak var titleView: UIView!
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
        setUpTitleView()
        setUpLabels()
    }
    
    private func setUpTitleView() {
        titleView.layer.borderColor = UIColor.lightGray.cgColor
        titleView.layer.borderWidth = 1.0
    }
    
    private func setUpLabels() {
        titleLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .black)
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
