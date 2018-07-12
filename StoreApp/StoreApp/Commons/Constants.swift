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
  static let list = "list"
}
