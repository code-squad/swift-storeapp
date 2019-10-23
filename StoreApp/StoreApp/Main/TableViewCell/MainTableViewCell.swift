//
//  MainTableViewCell.swift
//  StoreApp
//
//  Created by Cloud on 2019/10/23.
//  Copyright © 2019 Cloud. All rights reserved.
//

import UIKit
import Foundation
class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nPriceLabel: UILabel!
    @IBOutlet weak var sPriceLabel: UILabel!
    
    func configure(image: String, title: String, detail: String, nPrice: String?, sPrice: String) {
        guard let url = URL(string: image),
            let data = try? Data(contentsOf: url) else { return }
        let cellImage = UIImage(data: data)
        if let price = nPrice {
            let attributedString = NSMutableAttributedString(string: price)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                          value: 1,
                                          range: (price as NSString).range(of: price))
            nPriceLabel.attributedText = attributedString
            cellImageVIew.image = cellImage
            titleLabel.text = title
            detailLabel.text = detail
            nPriceLabel.text = price
            sPriceLabel.text = sPrice
        } else {
            cellImageVIew.image = cellImage
            titleLabel.text = title
            detailLabel.text = detail
            nPriceLabel.text = ""
            sPriceLabel.text = sPrice
        }
    }
}
