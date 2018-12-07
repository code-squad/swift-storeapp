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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!
    
    func configure(with item: StoreItem) {
        titleLabel.text = item.title
        descLabel.text = item.description
        priceLabel.text = item.s_price
        if let nPrice = item.n_price {
            priceLabel.text = nPrice + "   " + item.s_price
        }
        var badge = ""
        if let elements = item.badge {
            for element in elements {
                badge += element
            }
        }
        badgeLabel.text = badge
    }
}
