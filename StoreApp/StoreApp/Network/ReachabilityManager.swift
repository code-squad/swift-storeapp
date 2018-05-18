//
//  ReachabilityManager.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 5. 17..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class ReachabilityManager {
    static let sharedInstance = ReachabilityManager()
    private var networkManager: Reachability?

    private init() {
        networkManager = Reachability.init(hostName: Keyword.Network.hostName.value)
    }

    func isConnected() -> Bool {
        guard let networkManager = networkManager else { return false }
        return networkManager.currentReachabilityStatus().rawValue != 0
    }

    func start() {
        guard let networkManager = networkManager else { return }
        networkManager.startNotifier()
    }

    func stop() {
        guard let networkManager = networkManager else { return }
        networkManager.stopNotifier()
    }
}
