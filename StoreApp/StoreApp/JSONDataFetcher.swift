//
//  JSONDataFetcher.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 27..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct JSONDataFetcher {
    func load(with url: URL, completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200...299) ~= response.statusCode,
                error == nil else { return }
            completion(data)
        }
        task.resume()
    }
}
