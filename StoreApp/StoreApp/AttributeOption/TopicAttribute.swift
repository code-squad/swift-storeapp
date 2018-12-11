//
//  TopicAttribute.swift
//  StoreApp
//
//  Created by oingbong on 11/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

enum TopicAttribute: Attributable {
    case name
    case desc
    
    var style: [NSAttributedString.Key: Any] {
        let style = NSAttributedString.Key.self
        switch self {
        case .name:
            let result = [style.foregroundColor: UIColor.gray,
                          style.font: UIFont.systemFont(ofSize: 10)]
            return result
        case .desc:
            let result = [style.foregroundColor: UIColor.black,
                          style.font: UIFont.boldSystemFont(ofSize: 14)]
            return result
        }
    }
}
