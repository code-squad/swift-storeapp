//
//  BadgeAttribute.swift
//  StoreApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

enum BadgeAttribute {
    case purple
    case orange
    case black
    
    var style: [NSAttributedString.Key: Any] {
        let style = NSAttributedString.Key.self
        switch self {
        case .purple:
            let result = [style.backgroundColor: UIColor.purple,
                          style.foregroundColor: UIColor.white,
                          style.font: UIFont.systemFont(ofSize: 14)]
            return result
        case .orange:
            let result = [style.backgroundColor: UIColor.orange,
                          style.foregroundColor: UIColor.white,
                          style.font: UIFont.systemFont(ofSize: 14)]
            return result
        case .black:
            let result = [style.backgroundColor: UIColor.black,
                          style.foregroundColor: UIColor.white,
                          style.font: UIFont.systemFont(ofSize: 14)]
            return result
        }
    }
}
