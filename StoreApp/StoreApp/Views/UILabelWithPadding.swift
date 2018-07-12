//
//  UILabelWithPadding.swift
//  StoreApp
//
//  Created by yuaming on 12/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

class UILabelWithPadding: UILabel {
  @IBInspectable var topInset: CGFloat = 0
  @IBInspectable var bottomInset: CGFloat = 0
  @IBInspectable var leftInset: CGFloat = 0
  @IBInspectable var rightInset: CGFloat = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  convenience init(frame: CGRect, padding insets: UIEdgeInsets) {
    self.init(frame: frame)
    self.topInset = insets.top
    self.bottomInset = insets.bottom
    self.leftInset = insets.left
    self.rightInset = insets.right
  }
    
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset,
                              bottom: bottomInset, right: rightInset)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
    
  override var intrinsicContentSize: CGSize {
    var size = super.intrinsicContentSize
    size.width += leftInset + rightInset
    size.height += topInset + bottomInset
    return size
  }
  
  func removeInsets() {
    self.topInset = 0
    self.bottomInset = 0
    self.leftInset = 0
    self.rightInset = 0
  }
}
