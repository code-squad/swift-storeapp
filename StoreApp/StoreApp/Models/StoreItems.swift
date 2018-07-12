//
//  StoreItems.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class StoreItems {
  fileprivate var header: SectionHeader.Kind
  fileprivate var items: [StoreItem]
  
  init(header: SectionHeader.Kind, items: [StoreItem]) {
    self.header = header
    self.items = items
  }
  
  subscript(at index: Int) -> StoreItem {
    return items[index]
  }
  
  var title: String {
    return header.title
  }
  
  var subtitle: String {
    return header.subtitle
  }
  
  var count: Int {
    return items.count 
  }
}
