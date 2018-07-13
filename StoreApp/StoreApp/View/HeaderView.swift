//
//  CustomHeaderView.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 13..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class HeaderView: UITableViewCell {

    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!

    var data: Category! {
        didSet {
            self.shortLabel.text = data.description.short
            self.longLabel.text = data.description.long
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        shortLabel.textColor = UIColor.gray
        shortLabel.layer.borderColor = UIColor.gray.cgColor
        shortLabel.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
