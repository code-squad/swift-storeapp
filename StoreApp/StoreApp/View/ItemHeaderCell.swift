//
//  ItemHeaderCell.swift
//  StoreApp
//
//  Created by 육지수 on 10/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class ItemHeaderCell: UITableViewCell {
    // MARK: Constants
    static let height: CGFloat = 100

    // MARK: Outlets
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: Life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
