//
//  AttributeOption.swift
//  StoreApp
//
//  Created by oingbong on 07/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

enum AttributeOption {
    case title
    case desc
    case nPrice
    case sPrice
    case badge
    
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
        case .badge:
            let result = [style.backgroundColor: UIColor.purple,
                          style.foregroundColor: UIColor.white,
                          style.font: UIFont.systemFont(ofSize: 14)]
            return result
        }
    }
}
