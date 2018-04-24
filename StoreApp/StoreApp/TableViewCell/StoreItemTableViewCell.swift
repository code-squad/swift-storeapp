//
//  StoreItemTableViewCell.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 5..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class StoreItemTableViewCell: UITableViewCell {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var eventBadge: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(with storeItem: StoreItem) {
        titleLabel.text = storeItem.title
        detailLabel.text = storeItem.description
        priceLabel.text = storeItem.sPrice
        eventBadge.text = storeItem.badge?.reduce("", +)
    }

    func setImage(with file: URL) {
        menuImage.image = UIImage(named: file.path)
        self.setNeedsLayout()
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        menuImage.image = nil
//        titleLabel.text = nil
//        detailLabel.text = nil
//        priceLabel.text = nil
//        eventBadge.text = nil
//    }

}
