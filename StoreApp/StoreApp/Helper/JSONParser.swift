//
//  URLDownloader.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Downloader {
    typealias DecodeResult<T> = (Result<T>) -> Void
    enum Result<T> {
        case success([T])
        case failure(Error)
    }

    static func download<T: Decodable>(urlString: String, toType type: [T].Type,
                                       completionHandler: @escaping DecodeResult<T>) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode(type, from: data)
                completionHandler(.success(items))
            } catch let error {
                completionHandler(.failure(error))
            }
        }.resume()
    }

    static func download<T: Decodable>(urlString: String, toType type: [T].Type) -> [T]? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print(error)
        }
        return nil
    }

    static func getDataFromJSONFile(_ fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        var data: Data?
        do {
            data = try Data(contentsOf: url)
        } catch {
            NSLog(error.localizedDescription)
        }
        return data
    }

}
