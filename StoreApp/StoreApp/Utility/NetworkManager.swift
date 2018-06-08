//
//  NetworkManager.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 6. 7..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation
import Reachability

class NetworkManager: NSObject {
    
    var reachability: Reachability!
    static let sharedInstance: NetworkManager = NetworkManager()
    
    override init() {
        super.init()
        reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        guard let network = notification.object as? Reachability else { return }
        NotificationCenter.default.post(name: .connection, object: self, userInfo: [Keyword.Observer.connection.name: network.connection])
    }
    
}
