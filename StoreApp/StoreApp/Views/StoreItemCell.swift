//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: UILabel!
    
    var item: StoreItem! {
        didSet {
            self.titleLabel.text = item.title
            self.descriptionLabel.text = item.description
            
            // attributeString for priceLabels
            var spaceBetweenPrices = ""
            
            var attributedString = NSMutableAttributedString()
            if let normalPrice = item.nPrice {
                spaceBetweenPrices = "  "
                attributedString = NSMutableAttributedString(string: normalPrice)
                attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            }
            attributedString.append(NSAttributedString(string: "\(spaceBetweenPrices)\(item.sPrice)", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .heavy), .foregroundColor: #colorLiteral(red: 0.1703471243, green: 0.7560165524, blue: 0.737252295, alpha: 1)]))
            self.normalPriceLabel.attributedText = attributedString
        }
    }
    
    // init 과 awakeFromNib 차이점??
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        let itemImageViewWidth: CGFloat = 112
        itemImageView.translatesAutoresizingMaskIntoConstraints = true
        itemImageView.clipsToBounds = true
        itemImageView.frame.size = CGSize(width: itemImageViewWidth, height: itemImageViewWidth)
        itemImageView.layer.cornerRadius = itemImageViewWidth / 2
    }
}
