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
    static let shared = ReachabilityMonitor()
    private let networkManager: NetworkReachabilityManager?

    private init() {
        networkManager = NetworkReachabilityManager(host: Server.remote.api.hostName!)
    }

    var isAvailable: Bool {
        guard let networkManager = networkManager else { return false }
        return networkManager.isReachable
    }

    func startMonitoring() {
        guard let networkManager = networkManager else { return }
        networkManager.listener = { status in
            NotificationCenter.default.post(name: .connectionChanged, object: nil,
                                            userInfo: ["NetworkStatus": self.isAvailable])
        }
        networkManager.startListening()
    }

    func stopMonitoring() {
        guard let networkManager = networkManager else { return }
        networkManager.stopListening()
    }

}
