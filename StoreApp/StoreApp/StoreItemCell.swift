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
        let destinaionURL = LocalFileManager.filePath(fileName: fileName)
        var data: Data? = nil
        do {
            data = try Data(contentsOf: destinaionURL)
        } catch let error {
            print("read error : \(error.localizedDescription)")
        }
        if let imageData = data {
            menuImage.image = UIImage(data: imageData)
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
