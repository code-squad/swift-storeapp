//
//  DescriptionView.swift
//  StoreApp
//
//  Created by oingbong on 26/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class DescriptionView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var pointTitleLabel: UILabel!
    @IBOutlet weak var deliveryInfoTitleLabel: UILabel!
    @IBOutlet weak var deliberyFeeTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    
    func configure(with item: DetailItem, title: String) {
        titleLabel.text = title
        descriptionLabel.text = item.productDescription
        if let price = item.prices.first {
            priceLabel.text = price
        }
        pointLabel.text = item.point
        deliveryInfoLabel.text = item.deliveryInfo
        deliveryFeeLabel.text = item.deliveryFee
    }
    
    func itemInfo() -> (String?, String?) {
        return (titleLabel.text, priceLabel.text)
    }
}
