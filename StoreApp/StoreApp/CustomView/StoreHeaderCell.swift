//
//  StoreHeaderCell.swift
//  StoreApp
//
//  Created by oingbong on 11/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class StoreHeaderCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func configure(from item: Topic) {
        self.nameLabel.attributedText = decorateString(option: TopicAttribute.name, string: item.koreanName)
        self.nameLabel.layer.borderColor = UIColor.gray.cgColor
        self.nameLabel.layer.borderWidth = 1
        self.descLabel.attributedText = decorateString(option: TopicAttribute.desc, string: item.description)
    }
    
    func decorateString(option: Attributable, string: String) -> NSMutableAttributedString {
        let attributedOption = option.style
        let attributedString = NSMutableAttributedString(string: string, attributes: attributedOption)
        return attributedString
    }
}
