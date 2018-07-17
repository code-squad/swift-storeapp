//
//  StoreDataManager.swift
//  StoreApp
//
//  Created by yuaming on 12/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class StoreDataManager {
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

fileprivate extension StoreDataManager {
  func generateFileData() {
    FoodType.allValues.forEach { foodType in
      guard let data = FileLoader.data(file: foodType, fileType: FileTypes.json) else {
        return
      }
      
      list.append(StoreItems(header: foodType,
                             items: JSONConverter.decode(in: data, type: [StoreItem].self)))
    }
  }
  
  func requestData() {
    for foodType in FoodType.allValues {
      let url = API.shared.url(foodType.description)

      API.shared.request(withUrl: url) { resultType in
        switch resultType {
        case .success(let data):
          if let data = data {
            let decodedData = JSONConverter.decode(in: data, type: [StoreItem].self)
            self.list.append(StoreItems(header: foodType, items: decodedData))
          }
        case .error(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}

extension Notification.Name {
  static let storeList = Notification.Name("StoreList")
}
