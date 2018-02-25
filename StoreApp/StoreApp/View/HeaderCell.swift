//
//  HeaderCell.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell, StyleConfigurable {

    private(set) var title: InsetLabel = {
        let title = InsetLabel()
        let titleStyle = Style.HeaderTitle()
        title.layer.borderColor = titleStyle.borderColor
        title.layer.borderWidth = titleStyle.borderWidth
        title.setInsets(insets: titleStyle.insets)
        title.configure(style: titleStyle)
        return title
    }()

    private(set) var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.configure(style: Style.HeaderSubtitle())
        return subtitle
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func configure() {
        self.backgroundColor = Style.Header().backgroundColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

}
