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
            switch status {
            case .notReachable:
                print("------ notReachable")
            case .unknown:
                print("------ unknown")
            case .reachable(.ethernetOrWiFi):
                print("------ ethernetOrWiFi")
            case .reachable(.wwan):
                print("------ wwan")
            }
        }
        
        alamofireReachabilityManager?.startListening()
    }
}
