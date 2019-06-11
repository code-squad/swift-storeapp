//
//  ReachabilityViewController.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 6. 11..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ReachabilityViewController: UIViewController {
    private let reachability = Reachability.forInternetConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.borderWidth = 3
        if let status = reachability?.currentReachabilityStatus() {
            self.view.layer.borderColor = status.isConnect() ? #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        reachability?.startNotifier()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeBorderColor),
                                               name: .reachabilityChanged,
                                               object: reachability)
    }
    
    @objc private func changeBorderColor(_ noti: Notification) {
        guard let status = reachability?.currentReachabilityStatus() else { return }
        self.view.layer.borderColor = status.isConnect() ? #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
}
