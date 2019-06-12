//
//  NetworkStatus.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 6. 12..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class NetworkStatus {
    static let shared = NetworkStatus()
    
    private let reachability: Reachability
    
    private init() {
        self.reachability = Reachability.forInternetConnection()
        self.reachability.startNotifier()
    }
    
    func isConnected() -> Bool {
        let foo = reachability.currentReachabilityStatus()
        return foo != NotReachable
    }
}
