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
    
    func set(_ item: StoreItem) {
        itemTitle.text = item.title
        itemDescription.text = item.description
        sPrice.text = item.sPrice
        let imageData = ImageData().fetchItemImages(item.image)
        guard let data = imageData else { return }
        setItemImages(data)
        
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
    
    private func setItemImages(_ data: Data) {
        self.itemImage.image = UIImage(data: data)
    }

    override func prepareForReuse() {
        self.badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
}
