//
//  HeaderCell.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView, StyleConfigurable, Reusable {

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

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure() {
        let headerStyle = Style.Header()
        contentView.backgroundColor = headerStyle.backgroundColor
        contentView.layer.borderWidth = headerStyle.borderWidth
        contentView.layer.borderColor = headerStyle.borderColor
    }

    private func setupView() {
        contentView.addSubview(title)
        contentView.addSubview(subtitle)

        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true

        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.centerXAnchor.constraint(equalTo: title.centerXAnchor).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    }

}
