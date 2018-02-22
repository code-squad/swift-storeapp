//
//  HeaderCell.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell, StyleConfigurable {

    @IBOutlet weak var title: InsetLabel!
    @IBOutlet weak var subtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func configure() {
        self.backgroundColor = Style.Header().backgroundColor
        let titleStyle = Style.HeaderTitle()
        title.layer.borderColor = titleStyle.borderColor
        title.layer.borderWidth = titleStyle.borderWidth
        title.setInsets(insets: titleStyle.insets)
        configure(label: title, style: titleStyle)
        configure(label: subtitle, style: Style.HeaderSubtitle())
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
