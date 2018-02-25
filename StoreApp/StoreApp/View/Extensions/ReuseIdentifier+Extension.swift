//
//  ResueIdentifierExtension.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 24..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

protocol Reusable where Self: UIView {
    static var reuseId: String { get }
}

extension Reusable {
    static var reuseId: String {
        return String(describing: self)
    }
}
