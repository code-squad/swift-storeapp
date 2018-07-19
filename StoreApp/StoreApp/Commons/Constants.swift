//
//  Constants.swift
//  StoreApp
//
//  Created by yuaming on 12/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum FileTypes {
  case json
  
  var name: String {
    switch self {
    case .json: return "json"
    }
  }
}

struct Constants {
  static let storeList = "storeList"
  static let list = "list"
  static let detailTitle = "detailTitle"
  static let detailData = "detailData"
  static let thumbnail = "thumbnail"
  static let detailSection = "detailSection"
  static let imageIndex = "imageIndex"
  static let image = "image"
  
}
