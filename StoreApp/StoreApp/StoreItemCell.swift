//
//  StoreItemTableViewCell.swift
//  StoreApp
//
//  Created by rk on 2018. 7. 8..
//  Copyright © 2018년 fryb. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemSalePriceLabel: UILabel!
    @IBOutlet weak var itemBadgeLabel1: UILabel!
    @IBOutlet weak var itemBadgeLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
