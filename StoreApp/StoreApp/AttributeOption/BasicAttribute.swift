//
//  BasicAttribute.swift
//  StoreApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit
enum BasicAttribute {
    case title
    case desc
    
    var style: [NSAttributedString.Key: Any] {
        let style = NSAttributedString.Key.self
        switch self {
        case .title:
            let result = [style.font: UIFont.boldSystemFont(ofSize: 14)]
            return result
        case .desc:
            let result = [style.foregroundColor: UIColor.gray,
                          style.font: UIFont.systemFont(ofSize: 10)]
            return result
        }
    }
}
