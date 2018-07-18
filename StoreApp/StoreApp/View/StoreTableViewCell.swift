//
//  StoreTableViewCell.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 28..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var prices: UIStackView!
    @IBOutlet weak var badgeStack: UIStackView!
    
    var itemData: ItemData! {
        didSet {
            self.title.text = itemData.title
            self.itemDescription.text = itemData.description
            self.setPriceLabels(nPrice: itemData.n_price, sPrice: itemData.s_price)
            guard let badges = itemData.badge else {
                self.badgeStack.isHidden = true
                return
            }
            guard badgeStack.subviews.isEmpty else { return }
            self.setDiscountBadge(texts: badges)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.layer.borderColor = UIColor.gray.cgColor
        itemImage.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    private func setPriceLabels(nPrice: String?, sPrice: String) {
        guard let nPriceLabel = self.prices.arrangedSubviews[0] as? UILabel else { return }
        guard let sPriceLabel = self.prices.arrangedSubviews[1] as? UILabel else { return }
        if let normalPrice = nPrice {
            nPriceLabel.text = normalPrice
        } else {
            nPriceLabel.isHidden = true
        }
        sPriceLabel.text = sPrice
    }

    private func setDiscountBadge(texts: [String]) {
        let badges = texts.compactMap{ $0.discountBadge() }
        let badgeLabels = badges.map{ RoundedEdgeLabel().custom(withText: $0) }
        self.badgeStack.addArrangedSubviews(badgeLabels)
    }

}
