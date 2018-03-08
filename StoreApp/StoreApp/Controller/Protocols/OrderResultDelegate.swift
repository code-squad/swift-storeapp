//
//  OrderResultDelegate.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 7..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

protocol OrderResultDelegate: class {
    func toastOrderResult(_ orderInfo: OrderInfo)
}
