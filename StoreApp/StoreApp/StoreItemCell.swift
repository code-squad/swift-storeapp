//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class StoreItemCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var originPriceLabel: UILabel!
  @IBOutlet weak var salePriceLabel: UILabel!
  @IBOutlet weak var badgeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: true)
  }
  
  override func prepareForReuse() {
    self.titleLabel.text = ""
    self.descriptionLabel.text = ""
    self.originPriceLabel.text = ""
    self.salePriceLabel.text = ""
  }
  
  func setContact(_ data: StoreItem) {
    self.titleLabel.text = data.title
    self.descriptionLabel.text = data.description
    self.originPriceLabel.text = data.originPrice
    self.salePriceLabel.text = data.salePrice
    guard let badges = data.badges else {
      badgeLabel.isHidden = true
      return
    }
    
    self.badgeLabel.text = badges.reduce(" ", +)
  }
}
