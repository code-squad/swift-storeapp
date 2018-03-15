//
//  AppDelegate.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reachabilityMonitor: ReachabilityMonitor?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        StatusBar.setStatusBarBackgroundColor(color: UIColor.white)
        reachabilityMonitor = ReachabilityMonitor(hostName: Server.remote.api.hostName!)
        if var mainVC = window?.rootViewController?.childViewControllers.first as? ReachabilityDetectable {
            mainVC.reachabilityMonitor = reachabilityMonitor
        }
        reachabilityMonitor?.startMonitoring()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        reachabilityMonitor?.stopMonitoring()
    }

}
