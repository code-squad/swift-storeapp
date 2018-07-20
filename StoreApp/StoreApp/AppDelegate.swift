//
//  AppDelegate.swift
//  StoreApp
//
//  Created by yuaming on 09/07/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    NotificationCenter.default.addObserver(self, selector: #selector(updateConnectedFlag(_:)), name: Notification.Name.isConnected, object: nil)
    
    NetworkManager.shared.startObserver()
    setStatusBarOption()
    
    return true
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    NetworkManager.shared.stopObserver()
  }
  
  @objc fileprivate func updateConnectedFlag(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let isConnected = userInfo[Constants.isConnected] as? Bool else { return }
    
    drawBorder(isConnected: isConnected)
  }
  
  fileprivate func drawBorder(isConnected: Bool) {
    let rootView = window?.rootViewController?.view
    rootView?.layer.borderColor = isConnected ? UIColor.green.cgColor : UIColor.red.cgColor
    rootView?.layer.borderWidth = 3
  }
  
  fileprivate func setStatusBarOption() {
    if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
      statusBar.backgroundColor = UIColor.white
    }
  }
}

