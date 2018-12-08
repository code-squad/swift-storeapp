//
//  Decorating.swift
//  StoreApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

protocol Decorating {
    func configure(from item: StoreItem)
    func hiddenViewItem()
    func decorateString(option: Attributable, string: String) -> NSMutableAttributedString
}
