//
//  HeaderView.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 30..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class HeaderView: UITableViewCell {

    
    @IBOutlet weak var titleLabel: SectionLabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
