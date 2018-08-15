//
//  SectionHeaderView.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 15..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    
    var titleLabel: BadgeLabel = {
        var title = BadgeLabel()
        title.font = title.font.withSize(10.0)
        title.backgroundColor = .clear
        title.layer.borderWidth = 1
        title.layer.borderColor = UIColor.darkGray.cgColor
        title.textColor = .darkGray
        return title
    }()
    
    var descriptionLabel: UILabel = {
        var description = UILabel()
        description.textColor = UIColor.darkText
        description.font = UIFont.boldSystemFont(ofSize: 20.0)
        return description
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
    }
    
    func setLabel(with setter: HeaderViewLabelTextSetter) {
        titleLabel.text = setter.title
        descriptionLabel.text = setter.description
    }
}
