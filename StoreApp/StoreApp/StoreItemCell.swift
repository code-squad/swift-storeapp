//
//  StoreItemCell.swift
//  
//
//  Created by oingbong on 06/12/2018.
//

import UIKit

class StoreItemCell: UITableViewCell, Decorating {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceView: PriceView!
    @IBOutlet weak var badgeView: BadgeView!
    
    func configure(from item: StoreItem) {
        // MARK: image
        let fileName = item.image.components(separatedBy: "/").last!
        if let data = LocalFileManager.imageData(with: fileName) {
            menuImage.image = UIImage(data: data)
        }
        
        // MARK: title
        titleLabel.attributedText = decorateString(option: BasicAttribute.title, string: item.title)

        // MARK: desc
        descLabel.attributedText = decorateString(option: BasicAttribute.desc, string: item.description)
        
        // MARK: price
        priceView.configure(from: item)
        
        // MARK: badge
        badgeView.configure(from: item)
    }
    
    func decorateString(option: Attributable, string: String) -> NSMutableAttributedString {
        let attributedOption = option.style
        let attributedString = NSMutableAttributedString(string: string, attributes: attributedOption)
        return attributedString
    }
}
