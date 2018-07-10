//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: true)
  }
  
  override func prepareForReuse() {
    addSubview(foodImageView)
    updateConstraintsOfFoodImageView(isActive: true)
    
    addSubview(titleLabel)
    updateCostraintsOfTitleLabel(isActive: true)
    titleLabel.text = nil
    
    addSubview(descriptionLabel)
    updateConstraintsOfDescriptionLabel(isActive: true)
    descriptionLabel.text = nil

    addSubview(pricesStackView)
    updateConstraintsOfPricesStackView(isActive: true)
    
    addSubview(badgesStackView)
    updateConstraintsOfBadgesStackView(isActive: true)
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
  
  fileprivate var foodImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .red
    return imageView
  }()
  
  fileprivate var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.textColor = .black
    return label
  }()
  
  fileprivate var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .regular)
    label.textColor = .lightGray
    return label
  }()
  
  fileprivate var pricesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.spacing = 10
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
    return stackView
  }()
}

// MARK: - Updating constraints
fileprivate extension StoreItemCell {
  func updateConstraintsOfFoodImageView(isActive: Bool = true) {
    foodImageView.translatesAutoresizingMaskIntoConstraints = !isActive
    foodImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = isActive
    foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = isActive
    foodImageView.widthAnchor.constraint(equalToConstant: 90).isActive = isActive
    foodImageView.heightAnchor.constraint(equalTo: foodImageView.widthAnchor, multiplier: 1/1).isActive = isActive
  }
  
  func updateCostraintsOfTitleLabel(isActive: Bool = true) {
    titleLabel.translatesAutoresizingMaskIntoConstraints = !isActive
    titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = isActive
    titleLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 10).isActive = isActive
    titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 5).isActive = isActive
  }
  
  func updateConstraintsOfDescriptionLabel(isActive: Bool = true) {
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = !isActive
    descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = isActive
    descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = isActive
    descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = isActive
  }
  
  func updateConstraintsOfPricesStackView(isActive: Bool = true) {
    pricesStackView.translatesAutoresizingMaskIntoConstraints = false
    pricesStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4).isActive = isActive
    pricesStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = isActive
    pricesStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.trailingAnchor, constant: 20).isActive = isActive
  }
  
  func updateConstraintsOfBadgesStackView(isActive: Bool = true) {
    badgesStackView.translatesAutoresizingMaskIntoConstraints = !isActive
    badgesStackView.topAnchor.constraint(equalTo: pricesStackView.bottomAnchor, constant: 4).isActive = isActive
    badgesStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = isActive
    badgesStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.trailingAnchor, constant: 20).isActive = isActive
  }
}
