//
//  BadgeListCell.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class BadgeListCell: UICollectionViewCell, ReusableID {
    
    // MARK: - Outlets
    
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpAttributes()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)

        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size = size
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}

// MARK: - Attributes

extension BadgeListCell {
    private func setUpAttributes() {
        setUpBackgroundView()
        setUpLabel()
    }
    
    private func setUpBackgroundView() {
        badgeView.backgroundColor = StoreColor.purple
    }
    
    private func setUpLabel() {
        badgeLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        badgeLabel.textColor = .white
    }
}

// MARK: - Configure

extension BadgeListCell {
    func configure(_ title: String?) {
        badgeLabel.text = title
    }
}
