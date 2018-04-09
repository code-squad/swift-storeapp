//
//  HeaderTableViewCell.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 9..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
