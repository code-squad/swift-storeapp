//
//  BadgeListCell.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class BadgeListCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpAttributes()
    }

}

// MARK: - Attributes

extension BadgeListCell {
    private func setUpAttributes() {
        setUpLabel()
    }
    
    private func setUpLabel() {
        badgeLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        badgeLabel.textColor = .white
    }
}

// MARK: - Configure

extension BadgeListCell {
    func configure(_ title: String) {
        badgeLabel.text = title
    }
}
