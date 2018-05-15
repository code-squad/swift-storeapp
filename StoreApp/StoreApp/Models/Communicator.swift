//
//  communicator.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 25..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case url
    case data
    var log: String {
        switch self {
        case .url: return "Wrong URL"
        case .data: return "Data is not downloaded"
        }
    }
}

class Communicator {
    func detailInformation(with detailHash: String) {
        let urlString = Keyword.Detail.url.value + detailHash
        guard let url = URL(string: urlString) else {
            NSLog(NetworkError.url.log, [])
            return
        }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                NSLog(NetworkError.data.log, [])
                return
            }
            guard let detail = self.convert(from: data) else { return }
            NotificationCenter.default.post(name: .detailInformation, object: self,
                                            userInfo: ["detailInformation": detail.data])
        }).resume()
    }

    private func convert(from data: Data) -> Detail? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Detail.self, from: data)
        } catch {
            return nil
        }
    }

    func thumbImages(with urlStrings: [String]) {
        for index in urlStrings.indices {
            guard let url = URL(string: urlStrings[index]) else {
                NSLog(NetworkError.url.log, [])
                return
            }
            let urlSession = URLSession.shared
            urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else {
                    NSLog(NetworkError.data.log, [])
                    return
                }
                NotificationCenter.default.post(name: .thumbImages, object: self,
                                                userInfo: ["data": data, "index": index,
                                                           "totalCount": urlStrings.count])
            }).resume()
        }
    }

    func detailSection(with urlStrings: [String]) {
        for index in urlStrings.indices {
            guard let url = URL(string: urlStrings[index]) else {
                NSLog(NetworkError.url.log, [])
                return
            }
            let urlSession = URLSession.shared
            urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else {
                    NSLog(NetworkError.data.log, [])
                    return
                }
                NotificationCenter.default.post(name: .detailSection, object: self,
                                                userInfo: ["data": data])
            }).resume()
        }
    }
}
