//
//  NetworkModule.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/25.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import Foundation

struct BaseAPIResponse<StoreItem: Decodable>: Decodable {
    let statusCode: Int
    let body: [StoreItem]
}

class NetworkModule {
    private let defaultSession = URLSession(configuration: .default)
    private let session = URLSession.shared
    
    let jsonFilenames = ["main", "soup", "side"]
    
    init() {
        getData()
    }
    
    func getData() {
        jsonFilenames.forEach { (name) in
            let baseUrl = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/"
            guard let url = URL(string: baseUrl + name) else { return }
            
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                    
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let baseAPIResponse = try jsonDecoder.decode(BaseAPIResponse<StoreItem>.self, from: data)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getData"), object: nil, userInfo: ["json": baseAPIResponse.body, "section": name])
                
                } catch let jsonErr {
                    print("Error in decoding json", jsonErr)
                }
            }.resume()
        }
    }
}
