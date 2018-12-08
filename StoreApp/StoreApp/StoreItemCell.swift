//
//  StoreItemCell.swift
//  
//
//  Created by oingbong on 06/12/2018.
//

import UIKit

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceView: PriceView!
    @IBOutlet weak var nPriceLabel: UILabel!
    @IBOutlet weak var sPriceLabel: UILabel!
    @IBOutlet weak var badgeView: BadgeView!
    @IBOutlet weak var badgeFirstLabel: UILabel!
    @IBOutlet weak var badgeSecondLabel: UILabel!
    
    func configure(with item: StoreItem) {
        // title
        titleLabel.attributedText = decorateString(option: .title, string: item.title)
        
        // desc
        descLabel.attributedText = decorateString(option: .desc, string: item.description)
        
        // price
        priceView.addSubview(nPriceLabel)
        priceView.addSubview(sPriceLabel)
        priceView.configure(from: item)
        
        // badge
        badgeView.addSubview(badgeFirstLabel)
        badgeView.addSubview(badgeSecondLabel)
        badgeView.configure(from: item)
    }
    
    private func decorateString(option: BasicAttribute, string: String) -> NSMutableAttributedString {
        let attributedOption = option.style
        let attributedString = NSMutableAttributedString(string: string, attributes: attributedOption)
        return attributedString
    }
}
