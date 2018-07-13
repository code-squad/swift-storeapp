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
