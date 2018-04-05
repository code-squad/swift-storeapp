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
        setTitle(with: storeItem.title)
        setDetail(with: storeItem.description)
        setPrice(with: storeItem.s_price)
        setEventBadge(with: storeItem.badge)
    }

    private func setTitle(with title: String) {
        titleLabel.text = title
    }

    private func setDetail(with detail: String) {
        detailLabel.text = detail
    }

    private func setPrice(with price: String) {
        priceLabel.text = price
    }

    private func setEventBadge(with badge: [String]?) {
        eventBadge.text = badge?.reduce("", +)
    }

}
