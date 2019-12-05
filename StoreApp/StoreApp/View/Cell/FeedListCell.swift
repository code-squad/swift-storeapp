//
//  FeedListCell.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/04.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class FeedListCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpAttributes()
    }
}

// MARK: - Attributes

extension FeedListCell {
    private func setUpAttributes() {
        setUpImageView()
        setUpLabels()
    }
    
    private func setUpImageView() {
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.backgroundColor = .lightGray
    }
    
    private func setUpLabels() {
        titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        descriptionLabel.textColor = .darkGray
        
        priceLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        priceLabel.textColor = StoreColor.teal
    }
}
}
