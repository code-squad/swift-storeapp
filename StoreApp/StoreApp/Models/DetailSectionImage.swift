//
//  DetailSectionImage.swift
//  StoreApp
//
//  Created by yuaming on 18/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import UIKit

class DetailSectionImage {
  var index: Int?
  var image: UIImage? {
    didSet {
      if index != nil {
        NotificationCenter.default.post(name: .detailSection, object: nil, userInfo: [Constants.imageIndex: index, Constants.image: image])
      }
    }
  }
  
  init(_ imageUrl: String?, index: Int? = nil) {
    self.index = index
    loadImageData(imageUrl)
  }
}

extension DetailSectionImage: ImageLoaderable { }

extension Notification.Name {
  static let detailSection = Notification.Name(Constants.detailSection)
}
