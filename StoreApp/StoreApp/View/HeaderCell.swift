//
//  HeaderCell.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 15..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func set(_ headers: SectionHeader) {
        titleLabel.text = headers.title
        descriptionLabel.text = headers.subTitle
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.layer.borderWidth = 0.5
        titleLabel.layer.borderColor = UIColor.gray.cgColor
    }

    
}
