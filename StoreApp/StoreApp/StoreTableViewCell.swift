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
    @IBOutlet weak var naturalPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var badgeStackView: BadgeStackView!
    
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
    
    //MARK: Instance
    func show(with storeItem: StoreItem) {
        emptyAll()
        titleLabel.text = storeItem.title
        detailedDescriptionLabel.text = storeItem.description
        if let n_price = storeItem.n_price {
            naturalPriceLabel.attributedText = n_price.strikeThrough()
            naturalPriceLabel.isHidden = false
        }
        salePriceLabel.text = storeItem.s_price
        if let badges = storeItem.badge, badges.isEmpty == false {
            badgeStackView.add(badges: badges)
            badgeStackView.isHidden = false
        }
    }
    
    //MARK: Private
    private func emptyAll() {
        menuImageView.image = nil
        titleLabel.text = nil
        detailedDescriptionLabel.text = nil
        naturalPriceLabel.text = nil
        naturalPriceLabel.isHidden = true
        salePriceLabel.text = nil
        badgeStackView.removeAllArrangedSubviews()
        badgeStackView.isHidden = true
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        for subview in self.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributes = [NSAttributedString.Key.strikethroughStyle: 1]
        let strikeThroughString = NSAttributedString(string: self,
                                                     attributes: attributes)
        return strikeThroughString
    }
}
