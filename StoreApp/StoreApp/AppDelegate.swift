//
//  AppDelegate.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 13..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachabilityListener: ReachabilityListener? = ReachabilityListener()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window?.layer.borderWidth = 3
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateBorderColor(_:)), name: .connectionDidChanged, object: nil)
        reachabilityListener?.startListening()
        return true
    }
    
    @objc func updateBorderColor(_ notification: Notification) {
        guard let reachabilityListener = reachabilityListener else { return }
        window?.layer.borderColor = reachabilityListener.isReachable ? UIColor.green.cgColor : UIColor.red.cgColor
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        reachabilityListener?.stopListening()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
}

