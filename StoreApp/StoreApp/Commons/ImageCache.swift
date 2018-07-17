//
//  ImageCache.swift
//  StoreApp
//
//  Created by yuaming on 17/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class ImageCache {
  static let shared = ImageCache()
  
  fileprivate static let cacheDirectoryUrl: URL = {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
  }()
  
  static func fetchData(_ fileName: String, completionHandler: @escaping (_ data: Data?) -> Void) {
    let url = cacheDirectoryUrl.appendingPathComponent(fileName)
    if let data = FileManager.default.contents(atPath: url.path) {
      completionHandler(data)
    } else {
      completionHandler(nil)
    }
  }
  
  static func store(_ fileName: String, data: Data) {
    let url = cacheDirectoryUrl.appendingPathComponent(fileName)
    
    do {
      if FileManager.default.fileExists(atPath: url.path) {
        try FileManager.default.removeItem(at: url)
      }
      
      FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  static func clear() {
    do {
      let contents = try FileManager.default.contentsOfDirectory(atPath: cacheDirectoryUrl.path)
      for fileUrl in contents {
        try FileManager.default.removeItem(atPath: fileUrl)
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
