//
//  ReachabilityListner.swift
//  StoreApp
//
//  Created by moon on 2018. 9. 10..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation
import Alamofire

class ReachabilityListener {
    private let networkReachbilityManager: NetworkReachabilityManager
    
    init?() {
        guard let networkReachbilityManager = NetworkReachabilityManager() else { return nil }
        self.networkReachbilityManager = networkReachbilityManager
    }
    
    init?(host: String) {
        guard let networkReachbilityManager = NetworkReachabilityManager(host: host) else { return nil }
        self.networkReachbilityManager = networkReachbilityManager
    }
    
    var isReachable: Bool {
        return networkReachbilityManager.isReachable
    }
    
    func startListening() {
        networkReachbilityManager.listener = { _ in
            NotificationCenter.default.post(name: .connectionDidChanged, object: self)
        }
        networkReachbilityManager.startListening()
    }
    
    func stopListening() {
        networkReachbilityManager.stopListening()
    }
}
