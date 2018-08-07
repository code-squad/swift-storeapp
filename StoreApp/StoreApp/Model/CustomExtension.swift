//
//  CustomExtension.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 18..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let sectionSetComplete = Notification.Name("sectionSetComplete")
    static let thumbnailDownloaded = Notification.Name("thumbnailDownloaded")
    static let detailImageDownloaded = Notification.Name("detailImageDownloaded")
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
}

extension UIFont {
    func bold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: self.pointSize)
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}

