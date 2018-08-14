//
//  ItemCell.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 13..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var sPrice: UILabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    func reset(_ item: StoreItem) {
        itemTitle.text = item.title
        itemDescription.text = item.description
        sPrice.text = item.sPrice
        
        if let price = item.nPrice {
            nPrice.text = price
            nPrice.isHidden = false
        } else {
            nPrice.isHidden = true
        }
        
        guard let badges = item.badge else { return }

        for badge in badges {
            let newBadge = UILabel(frame: .zero)
            newBadge.text = badge
            newBadge.backgroundColor = .purple
            newBadge.textColor = .white
            badgeStackView.addArrangedSubview(newBadge)
        }
    }
    
    override func prepareForReuse() {
        self.badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
}
