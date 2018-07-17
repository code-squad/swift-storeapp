//
//  FoodType.swift
//  StoreApp
//
//  Created by yuaming on 13/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

enum FoodType: String {
  case main, soup, side
  
  static var allValues: [FoodType] {
    return [.main, .soup, .side]
  }
  
  var name: String {
    return self.rawValue
  }
  
  var title: String {
    switch self {
    case .main: return "메인반찬"
    case .soup: return "국.찌게"
    case .side: return "밑반찬"
    }
  }
  
  var subtitle: String {
    switch self {
    case .main: return "한그릇 뚝딱 메인 요리"
    case .soup: return "김이 모락모락 국.찌게"
    case .side: return "언제 먹어도 든든한 밑반찬"
    }
  }
}
