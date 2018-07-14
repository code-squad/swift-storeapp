//
//  NetworkManager.swift
//  SwiftShoppingApp
//
//  Created by GwakDoyoung on 14/07/2018.
//  Copyright © 2018 tucan9389. All rights reserved.
//

import Alamofire

class NetworkManager: NetworkReachabilityManager {
    
    static let manager = NetworkManager()
    
    var isConnected: Bool {
        switch networkReachabilityStatus {
        case .reachable( _):
            return true
        default:
            return false
        }
    }
    
    var reachabilityView: UIView? = nil {
        didSet {
            if let reachabilityView = self.reachabilityView {
                DispatchQueue.main.async {
                    reachabilityView.layer.borderWidth = 4
                    let listener: NetworkReachabilityManager.Listener = { status in
                        switch status {
                        case .unknown, .notReachable:
                            reachabilityView.layer.borderColor = UIColor.red.cgColor
                        case .reachable(_):
                            reachabilityView.layer.borderColor = UIColor.green.cgColor
                        }
                    }
                    self.listener = listener
                    listener(self.networkReachabilityStatus)
                }
            } else {
                self.listener = nil
            }
        }
    }
}
