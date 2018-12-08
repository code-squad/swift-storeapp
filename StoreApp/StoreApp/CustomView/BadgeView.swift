//
//  BadgeView.swift
//  StoreApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class BadgeView: UIStackView, Decorating {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(from item: StoreItem) {
        hiddenViewItem()
        
        // Badge
        if let badgeList = item.badge, badgeList.count > 0 {
            for index in 0..<badgeList.count {
                self.arrangedSubviews[index].isHidden = false
                guard let badgeLabel = self.arrangedSubviews[index] as? UILabel else { continue }
                badgeLabel.attributedText = decorateString(option: BadgeAttribute.purple, string: badgeList[index])
            }
        }
    }
    
    private func hiddenViewItem() {
        for subview in self.arrangedSubviews {
            subview.isHidden = true
        }
    }
    
    func decorateString(option: Attributable, string: String) -> NSMutableAttributedString {
        let attributedOption = option.style
        let attributedString = NSMutableAttributedString(string: string, attributes: attributedOption)
        return attributedString
    }
}
