//
//  SectionHeader.swift
//  StoreApp
//
//  Created by yuaming on 12/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

struct SectionHeader {
  fileprivate var title: String
  fileprivate var subtitle: String
  
  init(title: String, subtitle: String) {
    self.title = title
    self.subtitle = subtitle
  }
}

extension SectionHeader {
  enum Kind: Int, CustomStringConvertible {
    case main = 0, soup, side
    
    static var allValues: [Kind] {
      return [.main, .soup, .side]
    }
    
    var description: String {
      switch self {
      case .main: return "main"
      case .soup: return "soup"
      case .side: return "side"
      }
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
}

