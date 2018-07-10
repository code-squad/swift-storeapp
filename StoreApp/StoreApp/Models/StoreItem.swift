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
  var deliveryTypes: [String]?
  var detailHash: String?
  var image: String?
  var alt: String?
  var badges: [String]?
  
  enum CodingKeys: String, CodingKey {
    case title
    case description
    case originPrice = "n_price"
    case salePrice = "s_price"
    case deliveryTypes = "delivery_type"
    case detailHash = "detail_hash"
    case image
    case alt
    case badges = "badge"
  }
}
