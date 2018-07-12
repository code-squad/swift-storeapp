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
    
    if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
      statusBar.backgroundColor = UIColor.white
    }
    
    return true
  }
}

