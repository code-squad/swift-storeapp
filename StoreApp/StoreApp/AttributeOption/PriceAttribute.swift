//
//  PriceAttribute.swift
//  StoreApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

enum PriceAttribute: Attributable {
    case nPrice
    case sPrice
    
    var style: [NSAttributedString.Key: Any] {
        let style = NSAttributedString.Key.self
        switch self {
        case .nPrice:
            let result = [style.strikethroughStyle: 1,
                          style.strikethroughColor: UIColor.gray,
                          style.foregroundColor: UIColor.gray,
                          style.font: UIFont.systemFont(ofSize: 10)] as [NSAttributedString.Key: Any]
            return result
        case .sPrice:
            let result = [style.foregroundColor: UIColor.brown,
                          style.font: UIFont.boldSystemFont(ofSize: 14)]
            return result
        }
    }
}
