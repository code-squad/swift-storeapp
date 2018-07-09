//
//  JSONConverter.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct JSONConverter {
  typealias JSONData = [StoreItem]
  
  static func data(fileName: String, fileType: String) -> JSONData {
    guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else { return [] }
    
    let url = URL(fileURLWithPath: path)
    guard let data = try? Data(contentsOf: url) else { return [] }
    
    return decode(data)
  }
}

// MARK: - Decoding
fileprivate extension JSONConverter {
   static func decode(_ data: Data) -> JSONData {
    let jsonData: JSONData
    
    do {
      jsonData = try JSONDecoder().decode(JSONData.self, from: data)
    } catch {
      return []
    }
    
    return jsonData
  }
}


