//
//  JSONConverter.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct JSONConverter {
  static func decode<T: Codable>(in data: Data?, type: [T].Type) -> [T] {
    let jsonData: [T]
    
    do {
      guard let data = data else { return [] }
      
      jsonData = try JSONDecoder().decode(type, from: data)
    } catch let e {
      print(e)
      return []
    }
    
    return jsonData
  }
}

