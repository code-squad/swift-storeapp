//
//  URLDownloader.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class Downloader {

    typealias AfterTask = (Result) -> Void
    enum Result {
        case success(Data)
        case failure(Error)
    }

    static func post(to urlString: String, with payload: Data) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = payload
        URLSession.shared.dataTask(with: request).resume()
    }

    static func downloadWithDataTask(from urlString: String, completionHandler: @escaping AfterTask) {
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

    static func downloadToGlobalQueue(from urlString: String, completionHandler: @escaping AfterTask) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async(execute: {
            if let nsData = NSData(contentsOf: url) {
                let data = Data(referencing: nsData)
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(DownloadError.downloadFail(message: "다운로드 에러")))
            }
        })
    }

}

enum DownloadError: Error {
    case downloadFail(message: String)
}
