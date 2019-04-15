//
//  StoreHeaderCell.swift
//  StoreApp
//
//  Created by 윤동민 on 15/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class StoreHeaderCell: UITableViewCell {
    static let identifier = "headerCell"
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(at section: Int) {
        guard let theme = SectionTheme(rawValue: section) else { return }
        themeLabel.text = theme.getTheme()
        themeLabel.layer.borderWidth = 1
        themeLabel.layer.borderColor = UIColor.lightGray.cgColor
        descriptionLabel.text = theme.getDescription()
    }
}
