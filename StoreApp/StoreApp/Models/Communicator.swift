//
//  communicator.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 25..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class Communicator {
    func detailInformation(with detailHash: String) {
        let urlString = Keyword.Detail.url.value + detailHash
        guard let url = URL(string: urlString) else { return }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
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
}
