//
//  URLDownloader.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class Downloader {

    typealias AfterDownload = (Result) -> Void
    enum Result {
        case success(Data)
        case failure(Error)
    }

    static func download(from urlString: String, completionHandler: @escaping AfterDownload) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                guard let data = data else { return }
                completionHandler(.success(data))
            }
        }.resume()
    }

}
