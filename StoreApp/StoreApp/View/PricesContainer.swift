//
//  Prices.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 21..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class PricesContainer: UIStackView, StyleConfigurable {
    weak var normalPrice: UILabel!
    weak var salePrice: UILabel!

    override func awakeFromNib() {
        self.normalPrice = arrangedSubviews.first as? UILabel
        let secondIndex = arrangedSubviews.index(after: arrangedSubviews.startIndex)
        self.salePrice = arrangedSubviews[secondIndex] as? UILabel
        normalPrice.configure(style: Style.NormalPrice())
        salePrice.configure(style: Style.SalePrice())
        configure()
    }

    func configure() {
        self.axis = .horizontal
        self.distribution = .fill
        self.spacing = 5
    }

}
