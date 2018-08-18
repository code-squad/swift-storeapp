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
    
    static func fetchStoreItems(_ foodCategory: FoodCategory, completionHandler: @escaping (Data?, Error?) -> Void) {
        guard let url = StoreAPI.storeURL(category: foodCategory) else { return }
        
        // 임시코드입니다. 밤12시이후 진행하기 위해 Timeout을 임시로 걸었습니다.(기본 60초, 설정: 3초)
        // 3초 동안 응답없으면 파일로 부터 읽어옵니다. 단계 진행 후 삭제하겠습니다.
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3
        
        let session = URLSession(configuration: configuration)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
        task.resume()
    }
}
