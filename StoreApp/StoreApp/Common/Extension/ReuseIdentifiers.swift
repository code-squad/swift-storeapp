//
//  ReuseIdentifiers.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/05.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

protocol ReusableID {
    static var reuseID: String { get }
}

extension ReusableID {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableID { }

extension UITableViewHeaderFooterView: ReusableID { }
