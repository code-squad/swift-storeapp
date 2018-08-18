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
    
    static func storeURL(category: FoodCategory) -> URL? {
        guard var components = URLComponents(string: baseURL) else { return nil }
        components.port = 8080
        components.path = self.path
        components.path += "/\(category.rawValue)"
        return components.url
    }
}
