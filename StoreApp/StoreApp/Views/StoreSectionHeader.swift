//
//  StoreSectionHeader.swift
//  StoreApp
//
//  Created by yuaming on 12/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class StoreSectionHeader: UITableViewHeaderFooterView {
  fileprivate lazy var titleLabel: UILabelWithPadding = {
    let insets = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
    let label = UILabelWithPadding(frame: self.frame, padding: insets)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 11, weight: .regular)
    label.textColor = .white
    label.backgroundColor = .lightGray
    return label
  }()
  
  fileprivate lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.textColor = .black
    return label
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    initializeLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func prepareForReuse() {
    titleLabel.text = nil
    subtitleLabel.text = nil
  }
  
  func initializeLayout() {
    contentView.backgroundColor = .white
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.lightGray.cgColor
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(subtitleLabel)
    
    titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
    subtitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
    subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
  }
  
  func setContent(title: String, subtitle: String) {
    titleLabel.text = title
    subtitleLabel.text = subtitle
  }
}
