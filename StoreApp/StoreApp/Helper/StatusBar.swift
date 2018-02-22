//
//  StatusBar.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

struct StatusBar {
    static func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar =
            UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
}
