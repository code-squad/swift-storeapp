//
//  HeaderView.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class HeaderView: UITableViewCell {

    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var longDescription: UILabel!

    var data: Category! {
        didSet {
            self.shortDescription.text = data.description.short
            self.longDescription.text = data.description.long
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        shortDescription.layer.borderWidth = 0.5
        shortDescription.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
