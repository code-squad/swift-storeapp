//
//  OrderInfo.swift
//  StoreApp
//
//  Created by yuaming on 19/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct OrderInfo {
  fileprivate let name: String
  fileprivate let menu: String
  fileprivate let price: String
  
  init(name: String, menu: String, price: String) {
    self.name = name
    self.menu = menu
    self.price = price
  }
}

extension OrderInfo: CustomStringConvertible {
  var description: String {
    return "\(name)이 \(menu)를(을) \(price)을 주고 구매하였습니다 :)"
  }
}
