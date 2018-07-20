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
  fileprivate var reachabilityManager: Alamofire.NetworkReachabilityManager?
  
  fileprivate init() {
    self.reachabilityManager = Alamofire.NetworkReachabilityManager(host: host)
  }
  
  var isConnected: Bool {
    guard let reachabilityManager = reachabilityManager else { return false }
    return reachabilityManager.isReachable
  }
  
  func startObserver() {
    guard let reachabilityManager = self.reachabilityManager else { return }
    
    NotificationCenter.default.post(name: .isConnected,
                                    object: nil,
                                    userInfo: [Constants.isConnected: isConnected])
  
    reachabilityManager.startListening()
  }
  
  func stopObserver() {
    guard let reachabilityManager = self.reachabilityManager else { return }
    reachabilityManager.stopListening()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

extension Notification.Name {
  static let isConnected = Notification.Name(Constants.isConnected)
}
