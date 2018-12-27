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
            let networkStatus = self.network(with: status)
            NotificationCenter.default.post(name: NotificationKey.networkStatus, object: nil, userInfo: ["status": networkStatus])
        }
        alamofireReachabilityManager?.startListening()
    }
    
    private func network(with status: NetworkReachabilityManager.NetworkReachabilityStatus ) -> NetworkStatus {
        switch status {
        case .notReachable:
            return NetworkStatus.notReachable
        case .unknown:
            return NetworkStatus.unknown
        case .reachable(.ethernetOrWiFi):
            return NetworkStatus.ethernetOrWiFi
        case .reachable(.wwan):
            return NetworkStatus.wwan
        }
    }
    
    func initialNetworkStatus() -> Bool? {
        return alamofireReachabilityManager?.isReachable
    }
}
