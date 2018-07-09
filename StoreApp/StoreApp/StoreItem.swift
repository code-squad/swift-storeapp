//
//  StoreItem.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct StoreItem: Codable {
  var title: String?
  var description: String?
  var originPrice: String?
  var salePrice: String?
  var deliveryType: [String]?
  var detailHash: String?
  var image: String?
  var alt: String?
  var badge: [String]?
  
  enum CodingKeys: String, CodingKey {
    case title
    case description
    case originPrice = "s_price"
    case salePrice = "n_price"
    case deliveryType = "delivery_type"
    case detailHash = "detail_hash"
    case image
    case alt
    case badge
  }
}
