//
//  URLDownloader.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Downloader<T: Decodable>: NSObject {

    typealias DecodeResult = (Result) -> Void
    enum Result {
        case success([T])
        case failure(Error)
    }

    static func download(urlString: String, toType type: [T].Type, completionHandler: @escaping DecodeResult) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(type, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }

}
