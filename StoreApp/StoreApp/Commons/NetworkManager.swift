//
//  NetworkManager.swift
//  StoreApp
//
//  Created by yuaming on 20/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
  static let shared = NetworkManager()
  fileprivate let host = Host.base.path
  fileprivate var reachabilityManager: NetworkReachabilityManager
  
  fileprivate init() {
    if let reachabilityManager = NetworkReachabilityManager(host: host) {
      self.reachabilityManager = reachabilityManager
    } else {
      self.reachabilityManager = NetworkReachabilityManager(host: Host.apple.path)!
    }
  }
  
  var isConnected: Bool {
    return reachabilityManager.isReachable
  }
  
  func startObserver() {
    NotificationCenter.default.post(name: .isConnected,
                                    object: nil,
                                    userInfo: [Constants.isConnected: isConnected])
  
    reachabilityManager.startListening()
  }
  
  func stopObserver() {
    reachabilityManager.stopListening()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

extension Notification.Name {
  static let isConnected = Notification.Name(Constants.isConnected)
}
