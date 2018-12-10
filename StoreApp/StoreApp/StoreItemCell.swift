//
//  StoreItemCell.swift
//  
//
//  Created by oingbong on 06/12/2018.
//

import UIKit

class StoreItemCell: UITableViewCell, Decorating {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceView: PriceView!
    @IBOutlet weak var badgeView: BadgeView!
    
    func configure(from item: StoreItem) {
        // title
        titleLabel.attributedText = decorateString(option: BasicAttribute.title, string: item.title)
        
        // desc
        descLabel.attributedText = decorateString(option: BasicAttribute.desc, string: item.description)
        
        // price
        priceView.configure(from: item)
        
        // badge
        badgeView.configure(from: item)
    }
    
    func decorateString(option: Attributable, string: String) -> NSMutableAttributedString {
        let attributedOption = option.style
        let attributedString = NSMutableAttributedString(string: string, attributes: attributedOption)
        return attributedString
    }
}
