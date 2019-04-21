//
//  StoreTableViewCell.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 20..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    //MARK: IBOutlet
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailedDescriptionLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var naturalPriceLabel: UILabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    //MARK: Type
    static let nibName = "StoreTableViewCell"
    static let identifier = "storeTableViewCell"
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
