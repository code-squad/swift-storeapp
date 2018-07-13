//
//  FileLoader.swift
//  StoreApp
//
//  Created by yuaming on 13/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct FileLoader {
  static func data(file: FoodType, fileType: FileTypes) -> Data? {
    guard let path = Bundle.main.path(forResource: file.description, ofType: fileType.name) else { return nil }
    
    let url = URL(fileURLWithPath: path)
    guard let data = try? Data(contentsOf: url) else { return nil }
    
    return data
  }
}
