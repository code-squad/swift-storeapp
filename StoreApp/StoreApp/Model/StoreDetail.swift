//
//  StoreDetail.swift
//  StoreApp
//
//  Created by oingbong on 21/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class StoreDetail {
    private var hashData: DetailHashData?
    
    func parseURL(with hash: String, handler: @escaping (DetailItem) -> Void) {
        NetworkManager.jsonUrl(fileName: "Detail/" + hash) { (jsonData) in
            guard let data = jsonData, let item: DetailHashData = Parser.decode(from: data) else { return }
            self.hashData = item
            handler(item.data)
        }
    }
}
