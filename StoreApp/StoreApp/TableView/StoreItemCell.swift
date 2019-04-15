//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabels: PriceLabelsView!
    @IBOutlet weak var badgeLabels: BadgeLabelsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func set(_ itemDTO: StoreItemDTO) {
        titleLabel.text = itemDTO.title
        descriptionLabel.text = itemDTO.description
        priceLabels.set(itemDTO.s_price, itemDTO.n_price)
        badgeLabels.set(itemDTO.badge)
    }
    
//    private func madeBadgeLabels(_ badge: [String]) {
//        for index in 0..<badge.count {
//            badgeLabels[index].translatesAutoresizingMaskIntoConstraints = false
//            badgeLabels[index].isHidden = false
//            badgeLabels[index].text = badge[index]
//            badgeLabels[index].textColor = UIColor.white
//            badgeLabels[index].backgroundColor = UIColor.purple
//        }
//    }
}
