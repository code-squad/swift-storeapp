//
//  UIViewController+Extension.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 8..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import GSMessages

extension UIViewController {
    func presentError(_ errorType: NetworkError) {
        DispatchQueue.main.async(execute: {
            GSMessage.font = UIFont.boldSystemFont(ofSize: 15)
            GSMessage.warningBackgroundColor = UIColor.emerald
            self.showMessage(errorType.alert.title, type: .warning, options: [
                .animation(.slide),
                GSMessageOption.height(30.0),
                GSMessageOption.textColor(UIColor.white),
                GSMessageOption.textAlignment(NSTextAlignment.center),
                GSMessageOption.textNumberOfLines(1)
            ])
        })
    }
}
