//
//  URLDownloader.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class JSONParser {
//    private let urlString = "http://crong.codesquad.kr:8080/woowa/main"

//    enum Result {
//        case success([StoreItem])
//        case failure(Error)
//    }

//    typealias DownloadResultHandler = (Result) -> Void

//    func download(completionHandler: @escaping DownloadResultHandler) {
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data else { return }
//            let decoder = JSONDecoder()
//            do {
//                let items = try decoder.decode([StoreItem].self, from: data)
//                completionHandler(.success(items))
//            } catch let error {
//                completionHandler(.failure(error))
//            }
//        }.resume()
//    }

    static func decode<T: Decodable>(data: Data?, toType type: [T].Type) -> [T] {
        guard let data = data else { return [] }
        let decoder = JSONDecoder()
        var decodedData: [T] = [T]()
        do {
            decodedData = try decoder.decode(type, from: data)
        } catch {
            NSLog(error.localizedDescription)
        }
        return decodedData
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
