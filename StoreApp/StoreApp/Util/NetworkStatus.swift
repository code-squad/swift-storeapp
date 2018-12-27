//
//  NetworkStatus.swift
//  StoreApp
//
//  Created by oingbong on 27/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

enum NetworkStatus {
    case notReachable
    case unknown
    case ethernetOrWiFi
    case wwan
    
    var width: CGFloat {
        return 3
    }
    
    var color: CGColor {
        switch self {
        case .notReachable:
            return UIColor.red.cgColor
        case .unknown:
            return UIColor.purple.cgColor
        case .ethernetOrWiFi:
            return UIColor.blue.cgColor
        case .wwan:
            return UIColor.green.cgColor
        }
    }
}
