//
//  HashDataSetter.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 8. 4..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class HashDataSetter {

    class func tryDownload(url: URL, handler: @escaping ((ItemHashData?) -> Void)) {
        if NetworkManager.shared.reachable {
            HashDataSetter.set(url: url, handler: handler)
        } else {
            handler(nil)
        }
    }

    private class func set(url: URL, handler: @escaping((ItemHashData?)->Void)) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                do {
                    let parsedData = try JSONDecoder().decode(ItemHashData.self, from: data)
                    handler(parsedData)
                } catch {
                    handler(nil)
                }
            } else {
                handler(nil)
            }
            }.resume()
    }

}
