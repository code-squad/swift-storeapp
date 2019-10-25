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
    
    @IBOutlet weak var cellImageVIew: UIImageView! {
        didSet {
            cellImageVIew.backgroundColor = .red
            cellImageVIew.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nPriceLabel: UILabel!
    @IBOutlet weak var sPriceLabel: UILabel!
    
    override func prepareForReuse() {
        cellImageVIew.image = UIImage()
        titleLabel.text = ""
        detailLabel.text = ""
        nPriceLabel.text = ""
        sPriceLabel.text = ""
    }
    
    func setNPrice(nPrice: String?) {
        if let price = nPrice {
            let attributedString = NSMutableAttributedString(string: price)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                          value: 1,
                                          range: (price as NSString).range(of: price))
            nPriceLabel.attributedText = attributedString
        } else {
            nPriceLabel.text = ""
        }
    }
}
