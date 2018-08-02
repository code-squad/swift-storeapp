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
        guard let url = URL(string: OrderKeyword.url.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = OrderKeyword.httpPostRequest.rawValue
        request.addValue(OrderKeyword.dataType.rawValue, forHTTPHeaderField: OrderKeyword.headerField.rawValue)
        let payload = ["text": ">>> 배고픈 알린😋 : \(product.title)을(를) \(product.price)에 구매했습니다. 🥘🍲🍡🥗🍕🍛"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: payload, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request).resume()
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
