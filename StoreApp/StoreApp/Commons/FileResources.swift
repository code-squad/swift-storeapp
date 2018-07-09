//
//  FileResources.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum JSONFiles {
  case main
  
  var name: String {
    switch self {
    case .main:
      return "main"
    }
  }
}

enum FileTypes {
  case json
  
  var name: String {
    switch self {
    case .json:
      return "json"
    }
  }
}
