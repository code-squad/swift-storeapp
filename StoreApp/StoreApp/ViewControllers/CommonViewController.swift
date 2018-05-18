//
//  CommonViewController.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 5. 18..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        checkConnection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(connectionChanged(notification:)),
            name: .connectionChanged,
            object: nil
        )
    }

    @objc private func connectionChanged(notification: Notification) {
        checkConnection()
    }

    private func checkConnection() {
        if ReachabilityManager.sharedInstance.isConnected() {
            view.backgroundColor = UIColor.green
        } else {
            view.backgroundColor = UIColor.red
        }
    }
}
