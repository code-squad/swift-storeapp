//
//  API.swift
//  StoreApp
//
//  Created by yuaming on 13/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum API {
  case list(String)
}

extension API {
  var host: String {
    return "http://crong.codesquad.kr:8080/woowa"
  }
  
  var path: String {
    switch self {
    case let .list(id):
      return "/\(id)"
    }
  }
  
  var url: URL? {
    return URL(string: "\(host)\(path)")
  }
}
