//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabels: UIStackView!

    @IBOutlet var badgeLabels: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func set(_ itemDTO: StoreItemDTO) {
        removeArrangedAllViews()
        titleLabel.text = itemDTO.title
        descriptionLabel.text = itemDTO.description
    
        let s_priceLabel = madeS_PriceLabel(text: itemDTO.s_price)
        if let n_price = itemDTO.n_price {
            let n_priceLabel = madeN_PriceLabel(text: n_price)
            priceLabels.addArrangedSubview(n_priceLabel)
        }
        priceLabels.addArrangedSubview(s_priceLabel)
        if let badge = itemDTO.badge { madeBadgeLabels(badge) }
    }

    private func removeArrangedAllViews() {
        for subView in priceLabels.arrangedSubviews {
            priceLabels.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
        for label in badgeLabels { label.isHidden = true }
    }
    
    private func madeS_PriceLabel(text: String) -> UILabel {
        let s_priceLabel = UILabel()
        s_priceLabel.font = s_priceLabel.font.withSize(20)
        s_priceLabel.text = text
        s_priceLabel.textColor = UIColor.init(displayP3Red: 0, green: 0.55, blue: 0.55, alpha: 1.0)
        return s_priceLabel
    }
    
    private func madeN_PriceLabel(text: String) -> UILabel {
        let n_priceLabel = UILabel()
        n_priceLabel.font = n_priceLabel.font.withSize(15)
        n_priceLabel.attributedText = NSAttributedString(string: text, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        n_priceLabel.textColor = UIColor.lightGray
        return n_priceLabel
    }
    
    private func madeBadgeLabels(_ badge: [String]) {
        for index in 0..<badge.count {
            badgeLabels[index].isHidden = false
            badgeLabels[index].text = badge[index]
            badgeLabels[index].textColor = UIColor.white
            badgeLabels[index].backgroundColor = UIColor.purple
        }
    }
}
