//
//  UI+.swift
//  StoreApp
//
//  Created by yuaming on 10/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

extension UIColor {
  static let lightPink = UIColor(red: 239/255, green: 169/255, blue: 199/255, alpha: 1)
  static let mint = UIColor(red: 80/255, green: 218/255, blue: 223/255, alpha: 1)
}

extension String {
  var throughStrike: NSMutableAttributedString {
    let string = NSMutableAttributedString(string: self)
    let range = NSRange(location: 0, length: self.count)
    string.addAttribute(.strikethroughStyle, value: 1, range: range)
    string.addAttribute(.strikethroughColor, value: UIColor.lightGray, range: range)
    return string
  }
}
