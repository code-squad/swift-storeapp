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
    @IBOutlet weak var nPriceLabel: UILabel!
    @IBOutlet weak var sPriceLabel: UILabel!
    @IBOutlet weak var badgeFirstLabel: UILabel!
    @IBOutlet weak var badgeSecondLabel: UILabel!
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    func configure(with item: StoreItem) {
        hiddenStackViewItem()
        
        // title
        titleLabel.attributedText = decorateString(option: .title, string: item.title)
        
        // desc
        descLabel.attributedText = decorateString(option: .desc, string: item.description)
        
        // nPrice
        if let price = item.n_price {
            priceStackView.arrangedSubviews[0].isHidden = false
            nPriceLabel.attributedText = decorateString(option: .nPrice, string: price)
        }
        
        // sPrice
        priceStackView.arrangedSubviews[1].isHidden = false
        sPriceLabel.attributedText = decorateString(option: .sPrice, string: item.s_price)
        
        // Badge
        if let badgeList = item.badge, badgeList.count > 0 {
            for index in 0..<badgeList.count {
                badgeStackView.arrangedSubviews[index].isHidden = false
                guard let badgeLabel = badgeStackView.arrangedSubviews[index] as? UILabel else { continue }
                badgeLabel.attributedText = decorateString(option: .badge, string: badgeList[index])
            }
        }
    }
    
    private func hiddenStackViewItem() {
        for subview in priceStackView.arrangedSubviews {
            subview.isHidden = true
        }
        for subview in badgeStackView.arrangedSubviews {
            subview.isHidden = true
        }
    }
    
    private func decorateString(option: AttributeOption, string: String) -> NSMutableAttributedString {
        let attributedOption = option.style
        let attributedString = NSMutableAttributedString(string: string, attributes: attributedOption)
        return attributedString
    }
}
