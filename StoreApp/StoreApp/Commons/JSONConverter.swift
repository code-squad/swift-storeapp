//
//  JSONConverter.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct JSONConverter {
  static func decode<T: Decodable>(in data: Data?, type: [T].Type) -> [T] {
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
  
  static func decode<T: Decodable>(in data: Data?, type: T.Type) -> T? {
    let jsonData: T
    
    do {
      guard let data = data else { return nil }
      
      jsonData = try JSONDecoder().decode(type, from: data)
    } catch {
      print(error)
      return nil
    }
    
    return jsonData
  }
  
  static func encode<T: Encodable>(in data: T) -> Data? {
    let jsonEncoder = JSONEncoder()
    let encodedData: Data
    
    do {
      encodedData = try jsonEncoder.encode(data)
    } catch {
      print(error)
      return nil
    }
    
    return encodedData
  }
}

