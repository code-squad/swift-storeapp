//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
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
    titleLabel.text = nil
    descriptionLabel.text = nil
    
    normalPriceLabel.text = nil
    salePriceLabel.text = nil
    
    for case let badgeLabel as UILabel in badgesStackView.arrangedSubviews {
      badgeLabel.text = nil
      badgeLabel.backgroundColor = nil
    }
  }
  
  func setItem(_ data: StoreItem) {
    titleLabel.text = data.title
    descriptionLabel.text = data.description
    
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
        badgesStackView.addArrangedSubview(badgeLabel)
      }
    }
  }
  
  fileprivate func initializeLayout() {
    addSubview(thumbnailImageView)
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(pricesStackView)
    addSubview(badgesStackView)
    
    updateCostraintsOfTitleLabel(isActive: true)
    updateConstraintsOfDescriptionLabel(isActive: true)
    updateConstraintsOfBadgesStackView(isActive: true)
    updateConstraintsOfThumbnailImageView(isActive: true)
    updateConstraintsOfPricesStackView(isActive: true)
  }
  
  fileprivate var thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .red
    return imageView
  }()
  
  fileprivate var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.textColor = .black
    return label
  }()
  
  fileprivate var descriptionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12, weight: .regular)
    label.textColor = .lightGray
    return label
  }()
  
  fileprivate var pricesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  fileprivate var normalPriceLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 12, weight: .regular)
    return label
  }()
  
  fileprivate var salePriceLabel: UILabel = {
    let label = UILabel()
    label.textColor = .mint
    label.font = .systemFont(ofSize: 14, weight: .bold)
    return label
  }()
  
  fileprivate var badgeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .systemFont(ofSize: 10, weight: .regular)
    label.backgroundColor = .lightPink
    return label
  }()
  
  fileprivate var badgesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.spacing = 2
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
}

// MARK: - Updating constraints
fileprivate extension StoreItemCell {
  func updateConstraintsOfThumbnailImageView(isActive: Bool) {
    thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = isActive
    thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = isActive
    thumbnailImageView.widthAnchor.constraint(equalToConstant: 90).isActive = isActive
    thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 1/1).isActive = isActive
  }
  
  func updateCostraintsOfTitleLabel(isActive: Bool) {
    titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = isActive
    titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10).isActive = isActive
    titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 5).isActive = isActive
  }
  
  func updateConstraintsOfDescriptionLabel(isActive: Bool) {
    descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = isActive
    descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = isActive
    descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = isActive
  }
  
  func updateConstraintsOfPricesStackView(isActive: Bool) {
    pricesStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4).isActive = isActive
    pricesStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = isActive
    pricesStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.trailingAnchor, constant: 20).isActive = isActive
  }
  
  func updateConstraintsOfBadgesStackView(isActive: Bool) {
    badgesStackView.topAnchor.constraint(equalTo: pricesStackView.bottomAnchor, constant: 4).isActive = isActive
    badgesStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = isActive
    badgesStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.trailingAnchor, constant: 20).isActive = isActive
  }
}
