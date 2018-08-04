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

    let reachabilityManager = NetworkReachabilityManager()

    func startNetworkReachabilityObserver() {

        reachabilityManager?.listener = { status in
            switch status {

            case .notReachable:
                print("The network is not reachable") // 0

            case .unknown :
                print("It is unknown whether the network is reachable") // 1

            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection") // 2

            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection") // wwan number value
            }
            NotificationCenter.default.post(name: .reachabilityChanged, object: self, userInfo: ["reachabilityStatus":status])
            print("이전 연결: \(self.reachabilityManager?.previousFlags.rawValue))")
        }

        // start listening
        reachabilityManager?.startListening()
    }
}
