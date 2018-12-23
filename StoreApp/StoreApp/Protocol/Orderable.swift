//
//  Orderable.swift
//  StoreApp
//
//  Created by oingbong on 23/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

protocol Orderable: class {
    func orderToSlack(with orderSheet: OrderSheet)
}
