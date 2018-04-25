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
            if let data = data {
                DispatchQueue.main.async {
                    if let detailInformation = self.convert(from: data) {
                        
                    }
                }
            }
        }).resume()
    }

    private func convert(from data: Data) -> DetailInformation? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(DetailInformation.self, from: data)
        } catch {
            return nil
        }
    }
}
