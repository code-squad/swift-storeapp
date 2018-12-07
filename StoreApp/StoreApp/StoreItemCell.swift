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
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var sPrice: UILabel!
    @IBOutlet weak var badgeFirst: UILabel!
    @IBOutlet weak var badgeSecond: UILabel!
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    func configure(with item: StoreItem) {
        hiddenStackView()
        
        // title
        let titleAttributedOption = AttributeOption.title.style
        let titleAttributedString = NSMutableAttributedString(string: item.title, attributes: titleAttributedOption)
        titleLabel.attributedText = titleAttributedString
        
        // desc
        let descAttributedOption = AttributeOption.desc.style
        let descAttributedString = NSMutableAttributedString(string: item.description, attributes: descAttributedOption)
        descLabel.attributedText = descAttributedString
        
        // nPrice
        if let price = item.n_price {
            priceStackView.arrangedSubviews[0].isHidden = false
            let attributedOption = AttributeOption.nPrice.style
            let attributedString = NSMutableAttributedString(string: price, attributes: attributedOption)
            nPrice.attributedText = attributedString
        }
        
        // sPrice
        priceStackView.arrangedSubviews[1].isHidden = false
        let attributedOption = AttributeOption.sPrice.style
        let attributedString = NSMutableAttributedString(string: item.s_price, attributes: attributedOption)
        sPrice.attributedText = attributedString
        
        // Badge
        if let badgeList = item.badge, badgeList.count > 0 {
            for index in 0..<badgeList.count {
                badgeStackView.arrangedSubviews[index].isHidden = false
                let attributedOption = AttributeOption.badge.style
                let attributedString = NSMutableAttributedString(string: badgeList[index], attributes: attributedOption)
                guard let badgeLabel = badgeStackView.arrangedSubviews[index] as? UILabel else { continue }
                badgeLabel.attributedText = attributedString
            }
        }
    }
    
    private func hiddenStackView() {
        for subview in priceStackView.arrangedSubviews {
            subview.isHidden = true
        }
        for subview in badgeStackView.arrangedSubviews {
            subview.isHidden = true
        }
    }
}
