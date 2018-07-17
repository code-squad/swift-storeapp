//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
  fileprivate lazy var thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 50
    imageView.backgroundColor = .lightGray
    return imageView
  }()
  
  fileprivate lazy var itemTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.textColor = .black
    return label
  }()
  
  fileprivate lazy var itemDescriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12, weight: .regular)
    label.textColor = .lightGray
    return label
  }()
  
  fileprivate lazy var pricesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fill
    stackView.spacing = 10
    return stackView
  }()
  
  fileprivate lazy var normalPriceLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 12, weight: .regular)
    return label
  }()
  
  fileprivate lazy var salePriceLabel: UILabel = {
    let label = UILabel()
    label.textColor = .mint
    label.font = .systemFont(ofSize: 14, weight: .bold)
    return label
  }()
  
  fileprivate let badgeLabelInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 3)
  fileprivate lazy var badgeLabel: UILabelWithPadding = {
    let label = UILabelWithPadding(frame: self.frame)
    label.textColor = .white
    label.font = .systemFont(ofSize: 10, weight: .regular)
    label.backgroundColor = .lightPink
    return label
  }()
  
  fileprivate lazy var badgesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.spacing = 2
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
     initializeLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: true)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    thumbnailImageView.image = nil
    itemTitleLabel.text = nil
    itemDescriptionLabel.text = nil
    
    normalPriceLabel.text = nil
    salePriceLabel.text = nil
    
    pricesStackView.removeArrangedSubview(normalPriceLabel)
    pricesStackView.removeArrangedSubview(salePriceLabel)
    
    for case let badgeLabel as UILabelWithPadding in badgesStackView.arrangedSubviews {
      badgeLabel.text = nil
      badgeLabel.removeInsets()
      badgesStackView.removeArrangedSubview(badgeLabel)
    }
  }
  
  func setItem(_ data: StoreItem) {
    DispatchQueue.main.async {
      self.thumbnailImageView.image = data.thumbnail.image
    }
    
    itemTitleLabel.text = data.title
    itemDescriptionLabel.text = data.description
    
    if let normalPrice = data.normalPrice {
      normalPriceLabel.text = normalPrice
      normalPriceLabel.attributedText = normalPrice.throughStrike
      pricesStackView.addArrangedSubview(normalPriceLabel)
    }
    
    salePriceLabel.text = data.salePrice
    pricesStackView.addArrangedSubview(salePriceLabel)
    
    if let badges = data.badges {
      badges.forEach {
        badgeLabel.text = $0
        badgeLabel.addInsets(badgeLabelInsets)
        badgesStackView.addArrangedSubview(badgeLabel)
      }
    }
  }
  
  fileprivate func initializeLayout() {
    addSubview(thumbnailImageView)
    addSubview(itemTitleLabel)
    addSubview(itemDescriptionLabel)
    addSubview(pricesStackView)
    addSubview(badgesStackView)
    
    updateCostraintsOfTitleLabel(isActive: true)
    updateConstraintsOfDescriptionLabel(isActive: true)
    updateConstraintsOfBadgesStackView(isActive: true)
    updateConstraintsOfThumbnailImageView(isActive: true)
    updateConstraintsOfPricesStackView(isActive: true)
  }
}

// MARK: - Updating constraints
fileprivate extension StoreItemCell {
  func updateConstraintsOfThumbnailImageView(isActive: Bool) {
    thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = isActive
    thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = isActive
    thumbnailImageView.widthAnchor.constraint(equalToConstant: 90).isActive = isActive
    thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor).isActive = isActive
  }
  
  func updateCostraintsOfTitleLabel(isActive: Bool) {
    itemTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = isActive
    itemTitleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10).isActive = isActive
    itemTitleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 5).isActive = isActive
  }
  
  func updateConstraintsOfDescriptionLabel(isActive: Bool) {
    itemDescriptionLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 4).isActive = isActive
    itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor).isActive = isActive
    itemDescriptionLabel.trailingAnchor.constraint(equalTo: itemTitleLabel.trailingAnchor).isActive = isActive
  }
  
  func updateConstraintsOfPricesStackView(isActive: Bool) {
    pricesStackView.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor, constant: 4).isActive = isActive
    pricesStackView.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor).isActive = isActive
    pricesStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.trailingAnchor, constant: 20).isActive = isActive
  }
  
  func updateConstraintsOfBadgesStackView(isActive: Bool) {
    badgesStackView.topAnchor.constraint(equalTo: pricesStackView.bottomAnchor, constant: 4).isActive = isActive
    badgesStackView.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor).isActive = isActive
    badgesStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.trailingAnchor, constant: 20).isActive = isActive
  }
}
