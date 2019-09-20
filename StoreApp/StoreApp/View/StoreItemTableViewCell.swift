//
//  StoreItemTableViewCell.swift
//  StoreApp
//
//  Created by joon-ho kil on 9/7/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

class StoreItemTableViewCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var badge: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        Title.text = nil
        Description.text = nil
        Price.text = nil
        nPrice.text = nil
        badge.text = nil
    }
    
    func putInfo(_ storeItem: StoreItem) {
        self.Title.text = storeItem.title
        self.Description.text = storeItem.storeItemDescription
        self.Price.text = storeItem.sPrice
        
        if let nPrice = storeItem.nPrice {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: nPrice)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            self.nPrice.attributedText = attributeString
        }
        
        if let badgeName = storeItem.badge?.first {
            self.badge.text = badgeName
        }
        
        if let image = loadImage(from: storeItem.image) {
            self.itemImageView.image = image
        }
    }
    
    private func loadImage(from imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        let image = UIImage(data: data)
        
        return image
    }
}
