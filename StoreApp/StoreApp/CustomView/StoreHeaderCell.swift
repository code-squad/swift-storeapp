//
//  StoreHeaderCell.swift
//  StoreApp
//
//  Created by oingbong on 11/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class StoreHeaderCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func configure(from topic: Topic) {
        self.nameLabel.text = topic.koreanName
        self.descLabel.text = topic.desc
    }
}
