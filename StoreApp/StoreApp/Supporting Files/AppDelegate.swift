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
    var reachabilityMonitor: ReachabilityMonitor? {
        didSet {
            NotificationCenter.default.addObserver(self, selector: #selector(onConnectionChanged(_:)),
                                                   name: .connectionChanged, object: nil)
        }
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        StatusBar.setStatusBarBackgroundColor(color: UIColor.white)
        reachabilityMonitor = ReachabilityMonitor(hostName: Server.remote.api.hostName!)
        reachabilityMonitor?.startMonitoring()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        reachabilityMonitor?.stopMonitoring()
    }

    @objc private func onConnectionChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let isNetworkAvailable = userInfo["NetworkStatus"] as? Bool else { return }
        drawBorder(isNetworkAvailable)
        NotificationCenter.default.post(name: .onReconnected, object: nil)
    }

    func drawBorder(_ isNetworkAvailable: Bool) {
        let view = window?.rootViewController?.view
        let color: UIColor = (isNetworkAvailable) ? .green : .red
        view?.layer.borderColor = color.cgColor
        view?.layer.borderWidth = 5
    }

}
