//
//  PurchaseModel.swift
//  SwiftShoppingApp
//
//  Created by GwakDoyoung on 13/07/2018.
//  Copyright © 2018 tucan9389. All rights reserved.
//

import Foundation

protocol PurchaseModelDelegate {
    func didFinishPurchase(_ success: Bool, text: String)
}

class PurchaseModel {
    let url = "https://hooks.slack.com/services/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"
    var delegate: PurchaseModelDelegate? = nil
    
    func purchase(with text: String) {
        guard let url = URL(string: self.url) else { self.delegate?.didFinishPurchase(false, text: text); return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
        urlRequest.httpMethod = "POST"
        let data = ["text": text]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            urlRequest.httpBody = jsonData
            session.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data else { self.delegate?.didFinishPurchase(false, text: text); return }
                print(data)
                self.delegate?.didFinishPurchase(true, text: text)
            }.resume()
        } catch let e {
            print("error: ", e)
            self.delegate?.didFinishPurchase(false, text: text)
        }
        
    }
}
