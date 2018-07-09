//
//  StoreItems.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class StoreItems {
  private var items: [StoreItem] = [] {
    didSet {
      NotificationCenter.default.post(name: Notification.Name.storeItems, object: self)
    }
  }
  
  func generateData() {
    self.items = JSONConverter.data(fileName: "main", fileType: "json")
  }
  
  subscript(at index: Int) -> StoreItem {
    return items[index]
  }
  
  var count: Int {
    return items.count 
  }
}

extension Notification.Name {
  static let storeItems = Notification.Name("StoreItems")
}
