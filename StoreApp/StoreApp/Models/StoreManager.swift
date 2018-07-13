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
    self.init(list: [])
  }
  
  init(list: [StoreItems]) {
    self.list = list
  }
  
  func generateData() {
    requestData()
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

fileprivate extension StoreManager {
  func generateFileData() {
    FoodType.allValues.forEach { foodType in
      guard let data = FileLoader.data(file: foodType, fileType: FileTypes.json) else {
        return
      }
      
      list.append(StoreItems(header: foodType,
                             items: JSONConverter.decode(in: data, type: [StoreItem].self)))
    }
    
    sortByFoodType()
  }
  
  func requestData() {
    for foodType in FoodType.allValues {
      API.shared.request(foodType: foodType, type: [StoreItem].self) { resultType in
        switch resultType {
        case .success(let result):
          if let result = result as? [StoreItem] {
            self.list.append(StoreItems(header: foodType, items: result))
          }
        case .error(let error):
          print(error.localizedDescription)
        }
      }
    }
    
    sortByFoodType()
  }
  
  func sortByFoodType() {
    list.sort { $0.indexOfFoodType > $1.indexOfFoodType }
  }
}

extension Notification.Name {
  static let storeList = Notification.Name("StoreList")
}
