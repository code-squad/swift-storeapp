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
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var sPrice: UILabel!
    @IBOutlet weak var badges: UILabel!

    var itemData: ItemData! {
        didSet {
            self.title.text = itemData.title
            self.itemDescription.text = itemData.description
            self.nPrice.text = itemData.n_price
            self.sPrice.text = itemData.s_price
            guard let badges = itemData.badge else {
                self.badges.isHidden = true
                return
            }
            self.badges.text = badges.reduce("", +)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


