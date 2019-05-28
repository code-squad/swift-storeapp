//
//  Downloader.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 28..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct Downloader {
    func download(with url: URL, successHandler: @escaping (URL) -> Void) {
        URLSession.shared.downloadTask(with: url) { (fileURL, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let fileURL = fileURL,
                let response = response as? HTTPURLResponse,
                (200...299) ~= response.statusCode else { return }
            
            successHandler(fileURL)
            
            }.resume()
    }
}
