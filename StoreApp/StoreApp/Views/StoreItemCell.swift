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
    @IBOutlet weak var priceLabel: UILabel!
    
    var item: StoreItem! {
        didSet {
            self.titleLabel.text = item.title
            self.descriptionLabel.text = item.description
            self.priceLabel.text = item.sPrice
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
        itemImageView.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
    }
}
