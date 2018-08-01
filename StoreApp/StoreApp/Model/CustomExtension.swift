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
}

extension UIFont {
    func bold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: self.pointSize)
    }
}

extension Int {
    func rgbValue() -> CGFloat {
        return CGFloat(self) / 255.0
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: r.rgbValue(),
                  green: g.rgbValue(),
                  blue: b.rgbValue(),
                  alpha: 1)
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}

