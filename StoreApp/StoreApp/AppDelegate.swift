//
//  AppDelegate.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/04.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let rootViewController = window?.rootViewController as? FeedViewController {
            let feedViewPresenter = FeedViewPresenter(feedDataProvider: FeedDataProvider())
            rootViewController.presenter = feedViewPresenter
        }
        return true
    }

}

