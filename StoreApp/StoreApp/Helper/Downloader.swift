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

    // 비동기로 받는 테스트를 위해 로컬데이터에도 쓰레드 적용
    static func download(fileName: String, toType type: [T].Type, completionHandler: @escaping DecodeResult) {
        DispatchQueue.global().async {
            let data = getDataFromJSONFile(fileName)
            let result = decode(data: data, toType: type)
            completionHandler(.success(result))
        }
    }

    static func decode(data: Data?, toType type: [T].Type) -> [T] {
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
