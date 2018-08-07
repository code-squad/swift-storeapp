//
//  AppDelegate.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 6. 26..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        NotificationCenter.default.addObserver(self, selector: #selector(setStatusbarColor(notification:)), name: .reachabilityChanged, object: nil)
        NetworkManager.shared.startNetworkReachabilityObserver()
        return true
    }

    @objc func setStatusbarColor(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let status = userInfo["reachabilityStatus"] as? NetworkReachabilityManager.NetworkReachabilityStatus else { return }
        switch status {
        case .notReachable:
                    UIApplication.shared.statusBarView?.backgroundColor = UIColor(named: SystemColor.StatusBar.Pink.rawValue)
                    UIApplication.shared.statusBarStyle = .lightContent
                    UIApplication.shared.statusBarView?.stopBlink()
            print("The network is not reachable") // 0
        case .unknown :
                    UIApplication.shared.statusBarView?.backgroundColor = UIColor(named: SystemColor.StatusBar.Yellow.rawValue)
                    UIApplication.shared.statusBarStyle = .default
                    UIApplication.shared.statusBarView?.stopBlink()
                    print("It is unknown whether the network is reachable") // 1

        case .reachable(.ethernetOrWiFi):
                    UIApplication.shared.statusBarView?.backgroundColor = UIColor(named: SystemColor.StatusBar.Blue.rawValue)
                    UIApplication.shared.statusBarStyle = .lightContent
                    UIApplication.shared.statusBarView?.startBlink()
            print("The network is reachable over the WiFi connection") // 2

        case .reachable(.wwan):
                    UIApplication.shared.statusBarView?.backgroundColor = UIColor(named: SystemColor.StatusBar.Teal.rawValue)
                    UIApplication.shared.statusBarStyle = .lightContent
                    UIApplication.shared.statusBarView?.startBlink()
                    print("The network is reachable over the WWAN connection") // wwan number value
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension UIApplication {

    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }

}

extension UIView {

    func startBlink() {
        UIView.animate(withDuration: 0.8,
                       delay:0.0,
                       options:[.curveEaseInOut, .autoreverse, .repeat],
                       animations: { self.alpha = 0.3 },
                       completion: nil)
    }

    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}

