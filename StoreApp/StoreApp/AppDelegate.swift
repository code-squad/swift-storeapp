//
//  AppDelegate.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 4. 21..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import UIKit
import Toaster
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(drawConnectionBorder(notification:)), name: .connection, object: nil)
        return true
    }
    
    @objc func drawConnectionBorder(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let connection = userInfo[Keyword.Observer.connection.name] as? Reachability.Connection else { return }
        let view = window?.rootViewController?.view
        let borderAnimation = generateBorderAnimation()
        switch connection {
        case .cellular, .wifi:
            view?.layer.borderColor = UIColor.green.cgColor
            Toast(text: Keyword.toaster.connection.message).show()
            guard NetworkManager.sharedInstance.connectionStatus == .none else { return }
            NotificationCenter.default.post(name: .reloadSections, object: nil)
            NetworkManager.sharedInstance.connectionStatus = connection
        case .none:
            view?.layer.borderColor = UIColor.red.cgColor
            Toast(text: Keyword.toaster.unreachable.message).show()
            NetworkManager.sharedInstance.connectionStatus = .none
        }
        view?.layer.add(borderAnimation, forKey: Keyword.borderAnimation.key.value as? String)
        view?.setNeedsLayout()
    }
    
    private func generateBorderAnimation() -> CABasicAnimation {
        let borderAnimation: CABasicAnimation = CABasicAnimation(keyPath: Keyword.borderAnimation.keyPath.value as? String)
        borderAnimation.fromValue = Keyword.borderAnimation.from.value
        borderAnimation.toValue = Keyword.borderAnimation.to.value
        borderAnimation.duration = Keyword.borderAnimation.duration.value as! CFTimeInterval
        return borderAnimation
    }

}

