//
//  OrderDelegate.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 8. 1..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol OrderDelegate {
    func order(product: OrderItem)
}

extension OrderDelegate {
    func order(product: OrderItem) {
        print("구매: \(product.title)\n금액: \(product.price)")
    }
}

// Data object represents item ordered
struct OrderItem {
    var title: String
    var price: String

    init(title: String, prices: [String]) {
        self.title = title
        if prices.count == 1 {
            self.price = prices.first!
        } else {
            self.price = prices.last!
        }
    }
}
