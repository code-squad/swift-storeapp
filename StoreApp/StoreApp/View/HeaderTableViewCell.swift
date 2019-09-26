//
//  HeaderTableViewCell.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/24/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleButton.titleLabel?.text = nil
        descriptionLabel.text = nil
    }
    
    func putInfo(title: String, description: String) {
        self.titleButton.setTitle(title, for: .normal)
        self.descriptionLabel.text = description
        titleButton.layer.borderColor = UIColor.lightGray.cgColor
        titleButton.layer.borderWidth = 2
    }
}
