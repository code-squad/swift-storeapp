//
//  MenuTableViewCell.swift
//  StoreApp
//
//  Created by 백인철 on 2018. 7. 8..
//  Copyright © 2018년 Incheol. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var badge1Label: UILabel!
    @IBOutlet weak var badge2Label: UILabel!
    
    var storeItem: StoreItem? {
        didSet {
            self.titleLabel.text = storeItem?.title
            self.descriptionLabel.text = storeItem?.description
            self.originalPriceLabel.text = storeItem?.n_price
            self.salePriceLabel.text = storeItem?.s_price
            self.badge1Label.text = storeItem?.badge1
            self.badge2Label.text = storeItem?.badge2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
