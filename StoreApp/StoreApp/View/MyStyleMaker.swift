//
//  MyStyleMaker.swift
//  StoreApp
//
//  Created by Yoda Codd on 24/04/2019.
//  Copyright © 2019 Drake. All rights reserved.
//

import UIKit

class MyStyleMaker {
    /// 취소선 만드는 함수
    class func makeStrikeThrough(text: String) -> NSMutableAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
