//
//  StoreAPI.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 18..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation

struct StoreAPI {
    private static let baseURL = "http://crong.codesquad.kr"
    private static let portNumber = 8080
    private static let path = "/woowa"
    private static let successCode = 200
    
    static func storeURL(category: FoodCategory) -> URL? {
        guard var components = URLComponents(string: baseURL) else { return nil }
        components.port = portNumber
        components.path = self.path
        components.path += "/\(category.rawValue)"
        return components.url
    }
    
    static func fetchStoreItems(_ foodCategory: FoodCategory, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let url = StoreAPI.storeURL(category: foodCategory) else { return }
        let configure = URLSessionConfiguration.default
        configure.timeoutIntervalForRequest = 3
        
        let session = URLSession(configuration: configure)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == successCode else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
        task.resume()
    }
}
