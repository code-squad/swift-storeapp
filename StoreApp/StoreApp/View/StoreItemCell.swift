//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var originPriceLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var badgesView: BadgesView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with item: StoreItem) {
        self.titleLabel.text = item.title
        self.detailLabel.text = item.description
        
        if let nPrice = item.nPrice {
            self.originPriceLabel.isHidden = false
            self.originPriceLabel.text = nPrice
        } else {
            self.originPriceLabel.isHidden = true
        }

        self.discountedPriceLabel.text = item.sPrice

        if let badgeItems = item.badge {
            self.badgesView.configure(badgeItems: badgeItems)
        }
    }
}
