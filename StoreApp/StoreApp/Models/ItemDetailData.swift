//
//  ItemDetailData.swift
//  StoreApp
//
//  Created by yuaming on 17/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct ItemDetailData {
  let topImageUrl: String
  let thumbnailImageUrls: [String]
  let productDescription: String
  let point: String
  let deliveryInfo: String
  let deliveryFee: String
  let prices: [String]
  let detailSectionImageUrls: [String]
  var thumbnails: [Thumbnail]
  var detailSectionImages: [DetailSectionImage]
}

extension ItemDetailData: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.topImageUrl = try values.decode(String.self, forKey: .topImageUrl)
    self.thumbnailImageUrls = try values.decode([String].self, forKey: .thumbnailImageUrls)
    self.productDescription = try values.decode(String.self, forKey: .productDescription)
    self.point = try values.decode(String.self, forKey: .point)
    self.deliveryInfo = try values.decode(String.self, forKey: .deliveryInfo)
    self.deliveryFee = try values.decode(String.self, forKey: .deliveryFee)
    self.prices = try values.decode([String].self, forKey: .prices)
    self.detailSectionImageUrls = try values.decode([String].self, forKey: .detailSectionImageUrls)
    
    self.thumbnails = thumbnailImageUrls.enumerated().compactMap { (index, urlString) -> Thumbnail in
      Thumbnail(urlString, index: index)
    }
    
    self.detailSectionImages = detailSectionImageUrls.enumerated().compactMap { (index, urlString) -> DetailSectionImage in
      DetailSectionImage(urlString, index: index)
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case topImageUrl = "top_image"
    case thumbnailImageUrls = "thumb_images"
    case productDescription = "product_description"
    case point
    case deliveryInfo = "delivery_info"
    case deliveryFee = "delivery_fee"
    case prices
    case detailSectionImageUrls = "detail_section"
  }
}
