//
//  ViewModel.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 21..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol UILabelPresentable {
    var fontSize: CGFloat { get }
    var textColor: UIColor { get }
    var isBold: Bool { get }
    var textAlignment: NSTextAlignment { get }
}

struct Style {
    struct Header {
        private(set) var backgroundColor: UIColor = .white
        private(set) var borderColor: CGColor = UIColor.lightGray.cgColor
        private(set) var borderWidth: CGFloat = 1.0
    }

    struct HeaderTitle: UILabelPresentable {
        private(set) var fontSize: CGFloat = 12.0
        private(set) var textColor: UIColor = .gray
        private(set) var isBold: Bool = true
        private(set) var textAlignment: NSTextAlignment = .center
        private(set) var borderColor: CGColor = UIColor.lightGray.cgColor
        private(set) var borderWidth: CGFloat = 1.0
        private(set) var insets: UIEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
    }

    struct HeaderSubtitle: UILabelPresentable {
        private(set) var fontSize: CGFloat = 20.0
        private(set) var textColor: UIColor = .black
        private(set) var isBold: Bool = true
        private(set) var textAlignment: NSTextAlignment = .center
    }

    struct Title: UILabelPresentable {
        private(set) var fontSize: CGFloat = 16.0
        private(set) var textColor: UIColor = .black
        private(set) var isBold: Bool = true
        private(set) var textAlignment: NSTextAlignment = .left
    }

    struct Description: UILabelPresentable {
        private(set) var fontSize: CGFloat = 12.0
        private(set) var textColor: UIColor = .lightGray
        private(set) var isBold: Bool = false
        private(set) var textAlignment: NSTextAlignment = .left
    }

    struct NormalPrice: UILabelPresentable {
        private(set) var fontSize: CGFloat = 14.0
        private(set) var textColor: UIColor = .lightGray
        private(set) var isBold: Bool = false
        private(set) var textAlignment: NSTextAlignment = .left
    }

    struct SalePrice: UILabelPresentable {
        private(set) var fontSize: CGFloat = 12.0
        private(set) var textColor: UIColor = .emerald
        private(set) var isBold: Bool = true
        private(set) var textAlignment: NSTextAlignment = .left
        private(set) var font: UIFont? = UIFont(name: "AvenirNext-Medium", size: 18)
    }

    struct Badges {
        static let textAlignment: NSTextAlignment = .center
        static let font: UIFont = .boldSystemFont(ofSize: 14)
        static let textColor: UIColor = .white
        static let cornerRadius: CGFloat = 5
        static let clipsToBounds: Bool = true
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
    }

    enum BadgeType: String {
        case event = "이벤트특가"
        case launching = "론칭특가"
        case soldout = "품절"

        var color: UIColor {
            switch self {
            case .event: return UIColor.lightPurple
            case .launching: return UIColor.lightOrange
            case .soldout: return UIColor.deepGray
            }
        }
    }
}
