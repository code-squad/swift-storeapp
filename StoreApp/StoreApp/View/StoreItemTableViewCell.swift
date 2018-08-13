//
//  StoreItemTableViewCell.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class StoreItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: PriceLabel!
    @IBOutlet weak var salePriceLabel: PriceLabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    override func prepareForReuse() {
        normalPriceLabel.text = nil
        badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
