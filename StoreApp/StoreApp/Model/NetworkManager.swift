//
//  NetworkManager.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 8. 3..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {

    //shared instance
    static let shared = NetworkManager()
    private(set) var reachable: Bool = false

    let reachabilityManager = NetworkReachabilityManager()

    func startNetworkReachabilityObserver() {
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                self.reachable = false
            case .unknown :
                self.reachable = false
            case .reachable(.ethernetOrWiFi):
                self.reachable = true
            case .reachable(.wwan):
                self.reachable = true
            }
            NotificationCenter.default.post(name: .reachabilityChanged, object: self, userInfo: ["reachabilityStatus":status])
        }
        // start listening
        reachabilityManager?.startListening()
    }
}
