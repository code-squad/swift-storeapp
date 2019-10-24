//
//  MenuCell.swift
//  StoreApp
//
//  Created by Summer on 23/10/2019.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit


class MenuCell : UITableViewCell{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var salePrice: UILabel!
    @IBOutlet weak var badges: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        for subView in badges.arrangedSubviews{
            badges.removeArrangedSubview(subView)
        }
    }
}
