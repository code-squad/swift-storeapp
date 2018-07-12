//
//  JSONConverter.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct JSONConverter {
  static func data(file: SectionHeader.Kind, fileType: FileTypes) -> Data? {
    guard let path = Bundle.main.path(forResource: file.description, ofType: fileType.name) else { return nil }
    
    let url = URL(fileURLWithPath: path)
    guard let data = try? Data(contentsOf: url) else { return nil }
    
    return data
  }
  
  static func decode<T: Codable>(in data: Data, type: [T].Type) -> [T] {
    let jsonData: [T]
    
    do {
      jsonData = try JSONDecoder().decode(type, from: data)
    } catch let e {
      print(e.localizedDescription)
      return []
    }
    
    return jsonData
  }
}

