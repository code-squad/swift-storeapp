//
//  OrderToast.swift
//  StoreApp
//
//  Created by oingbong on 26/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

protocol OrderToast: class {
    func show(with orderSheet: OrderSheet, status isSuccess: Bool)
}
