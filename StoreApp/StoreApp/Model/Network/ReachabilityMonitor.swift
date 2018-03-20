//
//  ReachabilityMonitor.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 9..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import Alamofire

class ReachabilityMonitor {
    private let reachability: NetworkReachabilityManager!

    init(hostName: String) {
        reachability = NetworkReachabilityManager(host: hostName)
    }

    var isAvailable: Bool {
        return reachability.isReachable
    }

    func startMonitoring() {
        reachability.listener = { status in
            NotificationCenter.default.post(name: .connectionChanged, object: nil,
                                            userInfo: ["NetworkStatus": self.isAvailable])
        }
        reachability.startListening()
    }

    func stopMonitoring() {
        reachability.stopListening()
    }

}
