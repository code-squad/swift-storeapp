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
      let data = FileLoader.data(fileName: foodType.name, fileType: FileTypes.json)
      load(data, header: foodType)
    }
  }
  
  func requestData() {
    for foodType in FoodType.allValues {
      let url = API.shared.makeUrlInList(id: foodType.name)

      API.shared.sendRequest(withUrl: url) { resultType in
        switch resultType {
        case .success(let data):
          self.load(data, header: foodType)
        case .error(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  func load(_ data: Data?, header: FoodType) {
    if let data = data {
      let decodedData = JSONConverter.decode(in: data, type: [StoreItem].self)
      list.append(StoreItems(header: header, items: decodedData))
    }
  }
}

extension Notification.Name {
  static let storeList = Notification.Name(Constants.storeList)
}
