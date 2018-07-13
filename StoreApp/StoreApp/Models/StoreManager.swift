//
//  StoreManager.swift
//  StoreApp
//
//  Created by yuaming on 12/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class StoreManager {
  private var list: [StoreItems] {
    didSet {
      NotificationCenter.default.post(name: .storeList, object: nil, userInfo: [Constants.list: list])
    }
  }
  
  convenience init() {
    self.init(list: [StoreItems]())
  }
  
  init(list: [StoreItems]) {
    self.list = list
  }
  
  func generateData() {
    FoodType.allValues.forEach {
      guard let data = JSONConverter.data(file: $0, fileType: FileTypes.json) else {
        return
      }
      
      list.append(StoreItems(header: $0, items: JSONConverter.decode(in: data, type: [StoreItem].self)))
    }
  }
  
  var numberOfSections: Int {
    return list.count
  }
  
  func numberOfCells(_ section: Int) -> Int {
    return list[section].count
  }
  
  subscript(at section: Int) -> StoreItems {
    return list[section]
  }
}

extension Notification.Name {
  static let storeList = Notification.Name("StoreList")
}
