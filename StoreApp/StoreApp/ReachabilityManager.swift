//
//  ReachabilityManager.swift
//  StoreApp
//
//  Created by oingbong on 27/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation
import Alamofire

class ReachabilityManager {
    static let shared = ReachabilityManager()
    let alamofireReachabilityManager = NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        alamofireReachabilityManager?.listener = { status in
            var networkStatus = NetworkStatus.unknown
            switch status {
            case .notReachable:
                networkStatus = NetworkStatus.notReachable
            case .unknown:
                networkStatus = NetworkStatus.unknown
            case .reachable(.ethernetOrWiFi):
                networkStatus = NetworkStatus.ethernetOrWiFi
            case .reachable(.wwan):
                networkStatus = NetworkStatus.wwan
            }
            NotificationCenter.default.post(name: NotificationKey.networkStatus, object: nil, userInfo: ["status": networkStatus])
        }
        
        alamofireReachabilityManager?.startListening()
    }
}
